CREATE PROCEDURE [dbo].[uspApiInsertOnSpotDeals]
	@orderKey varchar(100),
	@xml xml
AS
	print '---INSERT ON SPOT DEALS---'
	declare
		@counterId int,
		@tiltId int,
		@orderDate varchar(20),
		@znumber varchar(20),
		@tax float,
		@count int = 0

	select 
		@counterId = (select top 1 id from ShiftAmount where IsActive = 1 order by id desc),
		@tiltId = c.value('@TiltId','int'),
		@orderDate = c.value('@Date','date'),
		@znumber = (select z_report_number from Shift_Opening where status = 1),
		@tax = (select isnull(tax_amount / 100, 0.13) from tax where isApplicable = 1)
		from @xml.nodes('/Order') as t(c)

	declare 
		@dealId int,
		@categoryName varchar(200),
		@dealName varchar(100),
		@dealQty float,
		@dealPrice float,
		@orderDetailId int,
		@dealComment varchar(300)

	print 'declaring cursor'
	declare cOnSpotDeals cursor local for select 
		c.value('@Id','int'), 
		c.value('@Name','varchar(100)'),
		c.value('@Quantity','float'),
		c.value('@Price','float') * c.value('@Quantity','float'),
		(select category_name from CategoryPOS where id = t.c.value('@CategoryId','int')),
		c.value('@Comment','varchar(300)')
		from @xml.nodes('/Order/OnSpotDeals/OnSpotDeal') as t(c)

	open cOnSpotDeals
	fetch next from cOnSpotDeals into @dealId, @dealName, @dealQty, @dealPrice, @categoryName, @dealComment

	while @@FETCH_STATUS != -1
	begin
		set @count = @count + 1
		print 'inserting order_detail' + cast(@count as varchar(10))
		Insert into Order_Detail
			(order_key, date, z_number, category_name, item_name, qty, price, tiltId, CounterId, Discount, PricebeforeDiscount, ItemId, tax, unit)

		select 
			@OrderKey, 
			cast(@orderDate as date), 
			@znumber, 
			@categoryName,
			@dealName,
			@dealQty,
			@dealPrice,
			@tiltId,
			@counterId,
			'0',
			@dealPrice, 
			@dealId,
			(@dealPrice * @tax), 
			''

		set @orderDetailId = @@IDENTITY

		print 'inserting DealsOnSpotItems' + cast(@count as varchar(10))
		insert into DealsOnSpotItems(Order_Key, Order_detailId, Deal_name, deal_Price, qty, Department, Category_name, Item_name, ItemQty, Price_Item, item_comment, TiltId)
		select 
			@OrderKey,
			@orderDetailId,
			@dealName,
			@dealPrice,
			@dealQty,
			(select department from CategoryPOS where id = t.c.value('@CategoryId','int')),
			(select category_name from CategoryPOS where id = t.c.value('@CategoryId','int')),
			t.c.value('@Name','varchar(100)'),
			((t.c.value('@Quantity','float') * @dealQty)),

			(t.c.value('@Price','float') * /*itemPrice*/
			(@dealQty * /*dealQuantity*/
			t.c.value('@Quantity','float') /*itemQuantity*/ )),

			'',
			@tiltId
			from @xml.nodes('/Order/OnSpotDeals/OnSpotDeal/DealItems/OnSpotDealItem') 
			as t(c)
			where c.value('../../@Id','int') = @dealId

		print 'inserting orderkot'
		insert Into OrderKot
			(orderkey,ItemId,Qty,KotStatus,Comments,Tiltid,ItemComment,LessReason,OrderDetailId)
		select
			@OrderKey, @dealId, @dealQty,0, 'NEW', @tiltId, @dealComment, '', @orderDetailId

		fetch next from cOnSpotDeals into @dealId, @dealName, @dealQty, @dealPrice, @categoryName, @dealComment
	end --WHILE END
	close cOnSpotDeals
	deallocate cOnSpotDeals