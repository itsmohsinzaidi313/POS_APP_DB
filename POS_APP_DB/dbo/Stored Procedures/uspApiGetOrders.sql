CREATE proc [dbo].[uspApiGetOrders]
@orderKey varchar(10)
as
declare 
	@data xml,
	@values xml,
	@items xml,
	@customer xml,
	@fixedDeals xml,
	@onSpotDeail xml,
	@tax float

begin try
	begin transaction
	IF(EXISTS(SELECT ID FROM Dine_In_Order WHERE is_delete = 0 AND account_status like 'not paid' AND order_key = @orderKey))
	begin
		select @tax = (tax_amount / 100) from Tax where isApplicable = 1

		select @items = t.c  from 
		(select isnull((select id from CategoryPOS where category_name = a.category_name)
		,(select id from CategoryPOS where category_name like 'OPEN FOOD')) [@CategoryId], 
		itemid [@Id],
		isnull((select codes from itempos where id = itemid),151605140604) [@Code], 
		item_name [@Name], 
		cast(qty as float) [@Quantity], 
		cast(PriceBeforeDiscount / qty as float) [@Price],
		cast((tax + PriceBeforeDiscount) / qty as float) [@TaxAmount],
		cast(price  as float) [@Amount],
		isnull((select top 1 itemcomment from orderkot where orderkey = @orderKey and itemid = a.itemid order by id desc),'') [@Comment]
		from Order_Detail a where order_key = @orderKey and category_name not in ('Deals','DealsOnSpot') for xml path('MenuItem'), root('Items')) as t(c)

		select @customer = t.c from 
		(select 
			isnull(id,'0') [@Id], 
			isnull(customer_name,' ') [@Name], 
			isnull(cell_no,' ') [@Contact], 
			isnull(address,' ') [@Address] 
			from CustomerPOS 
			where order_key = @orderKey for xml path('Customer')) as t(c)
		
		select @fixedDeals = t.c from 
		(select 
			a.ItemId [@Id], 
			(select id from CategoryPOS where category_name = a.category_name) [@CategoryId],
			(select codes from itempos where item_name = a.item_name) [@Code],
			a.item_name [@Name],
			a.qty [@Quantity],
			cast(a.PriceBeforeDiscount / a.qty as float) [@Price],
			cast((a.tax + a.PriceBeforeDiscount) / a.qty as float) [@TaxAmount],
			cast(a.price  as float) [@Amount],
			' ' [@Comment],
			(select t1.c1 from (select 
									(select id from ItemPOS where item_name = a.Item_name and is_delete = 0) [@Id],
									(select codes from ItemPOS where item_name = a.Item_name and is_delete = 0) [@Code],
									(select id from categorypos where category_name = a.Category_name) [@CategoryId],
									aa.Item_name [@Name], 
									aa.Item_Qty [@Quantity],
									cast(aa.Item_Price / aa.Item_Qty as float) [@Price],
									cast(((@tax * aa.Item_Price) + aa.Item_Price) / aa.Item_Qty as float) [@TaxAmount],
									cast(aa.Item_Price / aa.Item_Qty as float) [@Amount],
									' ' [@Comment]
									from Deals_Item aa where order_key = @orderKey
									for xml path('MenuItem'), root('Items'), TYPE) as t1(c1))
		from Order_Detail a
		where a.order_key = @orderKey and a.category_name = 'Deals' for xml path('FixedDeal'), root('FixedDeals')) as t(c)

		select @onSpotDeail = t.c from 
		(select  
			isnull(a.id,0) [@UniqueDealId],
			a.itemid [@Id],
			(select id from CategoryPOS where category_name = a.category_name) [@CategoryId],
			(select codes from itempos where id = a.ItemId) [@Code],
			a.item_name [@Name],
			a.qty [@Quantity],
			cast((a.PriceBeforeDiscount / a.qty) as float) as [@Price],
			cast(((a.tax + a.PriceBeforeDiscount) / a.qty) as float) as [@TaxAmount],
			cast(a.price as float) [@Amount],
			'' [@Comment],

			(select t1.c1 from (select 
				(select id from ItemPOS where item_name = aa.Item_name and is_delete = 0) [@Id],
				(select codes from ItemPOS where item_name = aa.Item_name and is_delete = 0) [@Code],
				(select id from categorypos where category_name = aa.Category_name) [@CategoryId],
				aa.Item_name [@Name], 
				aa.ItemQty [@Quantity],
				cast((aa.Price_Item / aa.ItemQty) as float) as [@Price],
				cast((((@tax * aa.Price_Item) + aa.Price_Item) / aa.ItemQty) as float) [@TaxAmount],
				cast((aa.Price_Item / aa.ItemQty) as float) [@Amount],
				'' [@Comment],
				(select dbo.udf_choise_to_number(ChooseAny) from DealsOnSpot where deal_name = aa.deal_name and item_name = aa.item_name) [@Choice] 
			from DealsOnSpotItems  aa 
			
			where aa.order_key = a.order_key
			for xml path('OnSpotDealItem'), root('DealItems'), TYPE) as t1(c1))

		from Order_Detail a
		where a.order_key = @orderKey and a.item_name in (select deal_name from DealsOnSpot) for xml path('OnSpotDeal'), root('OnSpotDeals')) as t(c)

		declare @waiter xml, @table xml
		select 
		@waiter = (select waiter.id_ [id], waiter.waiter_name [Name] from waiter where waiter_name = a.waiter_name for xml path('Waiter')),
		@table = (select id [id], [Tables].[tables] [Name]  from [Tables] where [Tables].[tables] = a.table_no for xml path('Table'))
		from Dine_In_Order a where a.order_key = @orderKey

		select 
		cast(t.c  as xml) [Order]
		from
			(select 
			isnull(a.waiter_name, '') [@Waiter],
			isnull(a.table_no, '0') [@Table],
			order_no as [@OrderNo], 
			@orderKey as [@Id], 
			isnull(cover,'0') [@Covers], 
			isnull(order_type,'') [@OrderType], 
			cast([order_date] as date) [@Date], 
			[order_time] as [@Time], 
			[android_device_no] [@UserId],
			Tiltid [@TiltId],

			isnull(@waiter, '<Waiter/>'),
			isnull(@table, '<Table/>'),

			isnull(@customer,'<Customer/>'),
			isnull(@items,'<Items/>'), 
			isnull(@fixedDeals,'<FixedDeals/>'),
			isnull(@onSpotDeail,'<OnSpotDeals/>')
			from Dine_In_Order a where a.order_key = @orderKey order by [date] desc for xml path ('Order')) as t(c)

	end
	else
	begin
		select isnull(@data,'<data>NoData</data>') as [data]
	end
	commit
end try
begin catch
rollback
print error_line()
print error_message()
select -1
end catch