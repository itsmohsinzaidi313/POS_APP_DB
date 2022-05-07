CREATE PROCEDURE [dbo].[uspApiUpdateFixedDeals]
	@xml xml
AS
--begin try
--begin transaction
declare 
	@orderKey varchar(10),
	@tiltId int,
	@znumber varchar(20),
	@counterId int,
	@orderDate date,
	@tax decimal(18,2),
	@itemId varchar(50), 
	@code varchar(50),
	@dealName varchar(50), 
	@qty float, 
	@dealPrice decimal(18,2),
	@dealAmount decimal(18,2),
	@comment varchar(300),
	@qtyDiff float

	select 
		@counterId = (select top 1 id from ShiftAmount where IsActive = 1 order by id desc),
		@tiltId = c.value('@TiltId','int'),
		@orderDate = c.value('@Date','date'),
		@orderKey = c.value('@Id','varchar(10)'),
		@znumber = (select  z_report_number from Shift_Opening where status = 1),
		@tax = (select top 1 isnull(tax_amount, 13) / 100 from Tax where isApplicable = 1)
	from @xml.nodes('/Order') as t(c)


	declare newOrder cursor local for 
	select 
		c.value('@Id', 'varchar(50)'), 
		c.value('@Code', 'varchar(50)'), 
		c.value('@Name', 'varchar(100)'), 
		c.value('@Quantity', 'float'),
		c.value('@Price', 'decimal(18,2)'),
		c.value('@Comment', 'varchar(300)'),
		c.value('@Price', 'decimal(18,2)') * c.value('@Quantity', 'float')
	From @xml.nodes('/Order/FixedDeals/FixedDeal') as t(c)
	
	open newOrder
	fetch next from newOrder into @itemId, @code, @dealName, @qty, @dealPrice, @comment, @dealAmount
	while @@FETCH_STATUS <> -1
	begin
	if(exists(select id from Order_Detail where ItemId = @itemId))
	begin
		print 'fixed deal exists'
		set @qtyDiff = @qty - (select sum(qty) from Order_Detail where order_key = @orderKey and itemid = @itemId);
	if(@qtyDiff > 0)
	begin
		print 'fixed deal quantity added ' + cast(@qtyDiff as varchar(max))
		insert Into OrderKot
			(orderkey, ItemId, Qty, KotStatus, Comments, Tiltid, ItemComment, LessReason, OrderDetailId)
		select
			@OrderKey, @itemId, ABS(@qtyDiff), 0,'ADDITIONAL', @tiltId, @comment, '', (select id from order_detail where itemid = @itemid and order_key = @orderkey)

		update Order_Detail 
		set 
			is_additional = 1 
			where itemid = @itemid and order_key = @orderkey 

		update Deals_Item 
			set 
				Deal_Qty = @qty, 
				deal_Price = @qty * @dealPrice,
				Item_Qty = (select a.qty from Deals a where a.deal_name = @dealName and a.item_name = Deals_Item.Item_name) * @qty,
				Item_Price = (select a.sale_price from ItemPOS a where a.item_name = Deals_Item.item_name) * ((select a.qty from Deals a where a.deal_name = @dealName and a.item_name = Deals_Item.item_name) * @qty)
			where Order_Key = @orderKey
	end
	else if(@qtyDiff < 0)
	begin
		print 'fixed deal quantity reduced ' + cast(@qtyDiff as varchar(max))
		insert into OrderKot
			(orderkey, ItemId, Qty, KotStatus, is_print, Comments, Tiltid, ItemComment, LessReason, OrderDetailId)
		select
			@OrderKey, @itemId, ABS(@qtyDiff), 0, 0, 'LESS', @tiltId, @comment, '', (select id from order_detail where itemid = @itemid and order_key = @orderkey)

		insert into [dbo].[Item_Less]
			([id], [order_key],[date],[z_num],[category],[item],[qty],[price] ,[server] ,[order_type] ,[shift] ,[tiltId] ,[android_detail_id] ,[is_print], [od_id])
		select 
			a.[order_key], a.[order_key], a.[order_date], a.[z_number], b.[category_name], b.[item_name], ABS(@qtyDiff), (ABS(@qtyDiff) * (price / qty)), a.[waiter_name], a.[order_type], GETDATE(), a.[Tiltid], a.[android_device_no], 0, b.[id]
		from Dine_In_Order a join order_detail b on b.[order_key] = a.[order_key] where a.[order_key] = @orderKey and b.[ItemId] = @itemId

		update Deals_Item 
			set 
				Deal_Qty = @qty, 
				deal_Price = @qty * @dealPrice,
				Item_Qty = (select a.qty from Deals a where a.deal_name = @dealName and a.item_name = Deals_Item.Item_name) * @qty,
				Item_Price = (select a.sale_price from ItemPOS a where a.item_name = Deals_Item.item_name) * ((select a.qty from Deals a where a.deal_name = @dealName and a.item_name = Deals_Item.item_name) * @qty)
			where Order_Key = @orderKey
		end
	update order_detail set qty = @qty, price = @dealAmount, tax = (@dealAmount * @tax), PriceBeforeDiscount = @dealAmount where order_key = @orderKey and Itemid = @itemId
	update OrderKot set ItemComment = @comment where OrderDetailId = (select id from Order_Detail where order_key = @orderKey and ItemId = @itemId)
	
	end
	else
	begin
		print 'fixed deal not exists'
		insert into Order_Detail
			(order_key, date, z_number, category_name, item_name, qty, price, tiltId, CounterId, Discount, PricebeforeDiscount, ItemId, tax, unit, is_additional)
		select 
			@OrderKey, cast(@orderDate as date), @znumber, (select category_name from ItemPOS where codes = @code), @dealName, @qty, @dealAmount, @tiltId, @counterId, '0', @dealAmount, @itemid, (@dealAmount * @tax), (select Unit from itempos where codes = @code), 1

		insert into Deals_Item(Order_Key, Order_Detail_id, Deal_name, deal_Price, Deal_Qty, Department, Category_name, Item_name, Item_Qty, Item_Price, item_comment)
		select 
			@OrderKey,
			@@IDENTITY,
			t.c.value('../../@Name','varchar(100)'),
			(t.c.value('../../@Price','float') * t.c.value('../../@Quantity','float')),
			t.c.value('../../@Quantity','float'),
			(select department from CategoryPOS where id = t.c.value('@CategoryId','int')),
			(select category_name from CategoryPOS where id = t.c.value('@CategoryId','int')),
			t.c.value('@Name','varchar(100)'),
			t.c.value('@Quantity','float'),
			(t.c.value('@Price','float') * (t.c.value('@Quantity','float') * t.c.value('../../@Quantity','float'))),
			''
		from @xml.nodes('/Order/FixedDeals/FixedDeal/Items/MenuItem') as t(c)
		where @itemId = t.c.value('../../@Id','int')


		insert into OrderKot
			(orderkey, ItemId, Qty, KotStatus, Comments, Tiltid, ItemComment, LessReason, OrderDetailId)
		select
			@OrderKey, @itemId, @qty, 0,'NEW', @tiltId, @comment, '',(select id from order_detail where itemid = @itemid and order_key = @orderkey)


		update Order_Detail set is_additional = 1 where order_key = @orderKey and Itemid = @itemId
	end
	fetch next from newOrder into @itemId, @code, @dealName, @qty, @dealPrice, @comment, @dealAmount
	end
	close newOrder
	deallocate newOrder


	declare 
		@oldItemId varchar(50),
		@oldQty int,
		@orderDetailId int
	declare oldItems cursor local for select id, itemid, qty, item_name from order_detail where order_key = @orderKey and item_name in (select deal_name from Deals)
	open oldItems
	fetch next from oldItems into @orderDetailId, @oldItemId, @oldQty, @dealName
		while @@FETCH_STATUS <> -1
		begin
			if(not exists 
				(select 1 From @xml.nodes('/Order/FixedDeals/FixedDeal') as t(c) 
				where c.value('@Id', 'varchar(50)') = @oldItemId))
			begin
				print 'fixed deal deleted'
				insert into [dbo].[Item_Less]
					([id], [order_key],[date],[z_num],[category],[item],[qty],[price] ,[server] ,[order_type] ,[shift] ,[tiltId] ,[android_detail_id] ,[is_print])
				select 
					b.[id], a.[order_key], a.[order_date], a.[z_number], b.[category_name], b.[item_name], b.[qty], b.[price], a.[waiter_name], a.[order_type], GETDATE(), a.[Tiltid], a.[android_device_no], 0
				from Dine_In_Order a join order_detail b on b.[order_key] = a.[order_key] 
				where a.[order_key] = @orderKey and b.[ItemId] = @oldItemId
		
				insert into orderKot
					(orderKey, comments, itemcomment, kotStatus, is_print, orderdetailid, itemid, qty, Tiltid)
				select 
					@orderKey, 'LESS', '', 0, 0, @orderDetailId, @oldItemid, @oldQty, @tiltId

				delete from Order_Detail where [order_key] = @orderKey and [ItemId] = @oldItemId
				delete from Deals_Item where Order_Key = @orderKey and Deal_name  = @dealName
			end
			fetch next from oldItems into @orderDetailId, @oldItemId, @oldQty, @dealName
		end
	close oldItems
	deallocate oldItems

	--commit
	--end try
	--begin catch
	--print 'error ' + cast(error_message() as varchar(max))
	--print 'line no ' + cast(error_line() as varchar(max))
	--end catch