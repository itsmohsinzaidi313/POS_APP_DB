CREATE proc updateOrder
@data xml
as
begin try
begin transaction
declare
	@values xml,
	@items xml,
	@covers int, 
	@orderType int, 
	@orderTypeTxt varchar(50),
	@znumber varchar(20),
	@counterId int, 
	@userid int,
	@Order1 int,
	@Order2 int,
	@id int,
	@orderid varchar(25),
	@waiterNo varchar(2), 
	@tableNo varchar(3), 
	@orderDate date,
	@amount decimal(18,2),
	@tax decimal(18,2),
	@tiltId int,
	@orderKey varchar(10),
	@time time

select @values = cast(c.value('values[1]','varchar(max)') as xml), @items = cast(c.value('items[1]','varchar(max)') as xml) from @data.nodes('data') as t(c)

select 
@covers = c.value('covers[1]','int'),
@orderType = c.value('locationId[1]','int'),
@counterId = c.value('counterId[1]','int'),
@userid = c.value('userid[1]','int'),
@waiterNo = c.value('waiterNo[1]','varchar(2)'),
@tableNo = c.value('tableNo[1]','varchar(3)'),
@orderDate = c.value('orderDate[1]','date'),
@amount = c.value('amount[1]','decimal(18,2)'),
@orderKey = c.value('orderKey[1]','varchar(10)')
from @values.nodes('values') as t(c)

select @tiltId = tiltid from tbl_user where id = @userid
set @time =  CAST(getdate() AS time)
select @tax = isnull((tax_amount / 100),1) from tax where isApplicable = 1
Select @znumber = z_report_number from Shift_Opening where status = 1
Select @Order1 = isnull(count(Od),0)+1, @Order2 = isnull(count(order_no),0) + 1 from Dine_In_Order where order_date =  DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE()))
set @orderid = @userid + '' + (SELECT CONVERT(VARCHAR(10), SYSDATETIME(),12)) + '' + CONVERT(varchar(10), @userid) + CONVERT(varchar(10), @Order2) + '-' + Convert(varchar(10), @userId)

if(@orderType = 1)
begin
	set @orderTypeTxt = 'DINE IN'
end
else if(@orderType = 2)
begin
	set @orderTypeTxt = 'TAKE AWAY'
end
else if(@orderType = 3)
begin
	set @orderType = 'DELIVERY'
end

if(@OrderKey > 0)
begin
	declare 
		@itemId int, 
		@itemName varchar(50), 
		@qty decimal(5,2), 
		@itemAmount decimal(18,2),
		@qtyDiff int

	declare newOrder cursor for 
	select 
		(select id from itempos where codes = c.value('code[1]', 'varchar(50)')), 
		c.value('name[1]', 'varchar(100)'), 
		c.value('quantity[1]', 'int'),
		c.value('amount[1]','decimal(18,2)')
	From @items.nodes('items/item') as t(c)

	open newOrder
	fetch next from newOrder into @itemId, @itemName, @qty, @itemAmount

	while @@FETCH_STATUS = 0
	begin
		if(exists (select id from Order_Detail where ItemId = @itemId))
		begin
			set @qtyDiff = @qty - (select sum(qty) from Order_Detail where order_key = @orderKey);
			if(@qtyDiff > 0)
			begin
				Insert Into OrderKot
					(orderkey, ItemId, Qty, KotStatus, Comments, Tiltid, ItemComment, LessReason, OrderDetailId, order_type)
				Select
					@OrderKey, @itemId, ABS(@qtyDiff), 0,'', @tiltId, '', '', (select id from order_detail where itemid = @itemid and order_key = @orderkey), 'pos'
			end
			else if(@qtyDiff < 0)
			begin
				Insert Into OrderKot
					(orderkey, ItemId, Qty, KotStatus, Comments, Tiltid, ItemComment, LessReason, OrderDetailId, order_type)
				Select
					@OrderKey, @itemId, ABS(@qtyDiff), 0, 'LESS', @tiltId, '', '',(select id from order_detail where itemid = @itemid and order_key = @orderkey), 'pos'

				INSERT INTO [dbo].[Item_Less]
					([id], [order_key],[date],[z_num],[category],[item],[qty],[price] ,[server] ,[order_type] ,[shift] ,[tiltId] ,[android_detail_id] ,[is_print])
				SELECT 
					b.[id], a.[order_key], a.[order_date], a.[z_number], b.[category_name], b.[item_name], b.[qty], b.[price], a.[waiter_name], a.[order_type], GETDATE(), a.[Tiltid], a.[android_device_no], 0
				FROM Dine_In_Order a join order_detail b on b.[order_key] = a.[order_key] where a.[order_key] = @orderKey and b.[ItemId] = @itemId
			end
		update order_detail set qty = @qty where order_key = @orderKey
		end
		else
		begin
			Insert Into OrderKot
				(orderkey, ItemId, Qty, KotStatus, Comments, Tiltid, ItemComment, LessReason, OrderDetailId, order_type)
			Select
				@OrderKey, @itemId, ABS(@qtyDiff), 0,'', @tiltId, '', '',(select id from order_detail where itemid = @itemid and order_key = @orderkey), 'pos'

			Insert into Order_Detail
				(order_key, date, z_number, category_name, item_name, qty, price, tiltId, CounterId, Discount, PricebeforeDiscount, ItemId, tax, unit, is_additional)
			Select 
				@OrderKey, cast(@orderDate as date), @znumber, (select category_name from ItemPOS where id = @itemId), @itemName, @qty, @itemAmount, @tiltId, @counterId, '0', @qty * @itemAmount, (select id from ItemPOS where id = @itemid), (@itemAmount * @tax), (select Unit from itempos where id = @itemId), 1
		end
		fetch next from newOrder into @itemId, @itemName, @qty
	end
	close newOrder
	deallocate newOrder


	declare oldOrder cursor for select id, itemid from order_detail where order_key = @orderkey
	open oldOrder
	fetch next from oldOrder into @id, @itemid

	while @@FETCH_STATUS = 0
	begin
		if(not exists(select c.value('name[1]', 'varchar(100)') From @items.nodes('items/item') as t(c) where c.value('code[1]', 'varchar(50)') = (select codes from itempos where id = @itemid)))
		begin
			INSERT INTO [dbo].[Item_Less]
					([id], [order_key],[date],[z_num],[category],[item],[qty],[price] ,[server] ,[order_type] ,[shift] ,[tiltId] ,[android_detail_id] ,[is_print])
			SELECT 
				b.[id], a.[order_key], a.[order_date], a.[z_number], b.[category_name], b.[item_name], b.[qty], b.[price], a.[waiter_name], a.[order_type], GETDATE(), a.[Tiltid], a.[android_device_no], 0
			FROM Dine_In_Order a join order_detail b on b.[order_key] = a.[order_key] where a.[order_key] = @orderKey and b.[ItemId] = @itemId

			delete from Order_Detail where [order_key] = @orderKey and [ItemId] = @itemId
		end
		fetch next from oldOrder into @itemid
	end
	close oldOrder
	deallocate oldOrder

end
commit
SELECT @@ROWCOUNT
end try
begin catch
rollback
close newOrder
deallocate newOrder
PRINT ERROR_LINE()
PRINT ERROR_MESSAGE()
select -1
end catch