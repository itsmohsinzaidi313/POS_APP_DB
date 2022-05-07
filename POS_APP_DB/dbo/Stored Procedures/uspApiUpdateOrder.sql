
CREATE proc [dbo].[uspApiUpdateOrder]
@xml xml
as
begin try
begin transaction
declare
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
	@orderTime varchar(10),
	@tax decimal(18,2),
	@tiltId int,
	@orderKey varchar(10),
	@time time,
	@count int,
	@totalAmount float,
	@subTotal float,
	@totalTax float
	
select 
	@covers = c.value('@Covers','int'),
	@orderType = c.value('@OrderType','int'),
	@counterId = (select top 1 id from ShiftAmount where IsActive = 1 order by id desc),
	@userid = c.value('@UserId','int'),
	@tiltId = c.value('@TiltId','int'),
	@waiterNo = c.value('@Waiter','varchar(2)'),
	@tableNo = c.value('@Table','varchar(3)'),
	@orderDate = c.value('@Date','date'),
	@orderTime = c.value('@Time','varchar(10)'),
	@orderKey = c.value('@Id','varchar(10)'),
	@totalAmount = c.value('@TotalAmount','decimal(18,2)'),
	@subTotal = c.value('@SubTotal','decimal(18,2)'),
	@totalTax = c.value('@TotalTax','decimal(18,2)')
from @xml.nodes('Order') as t(c)

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
print 'orderType'
if(@OrderKey > 0)
begin

	update Dine_In_Order set amount = @totalAmount where order_key = @orderKey
	declare 
		@itemId varchar(50), 
		@code varchar(50),
		@itemName varchar(50), 
		@qty float, 
		@itemPrice decimal(18,2),
		@itemAmount decimal(18,2),
		@comment varchar(300),
		@qtyDiff float

	print 'declaring newOrder cursor'
	declare newOrder cursor local for 
	select 
		c.value('@Id', 'varchar(50)'), 
		c.value('@Code', 'varchar(50)'), 
		c.value('@Name', 'varchar(100)'), 
		c.value('@Quantity', 'float'),
		c.value('@Price', 'decimal(18,2)'),
		c.value('@Comment', 'varchar(300)'),
		c.value('@Quantity', 'float') * c.value('@Price', 'decimal(18,2)')
	From @xml.nodes('Order/Items/MenuItem') as t(c)
	
	open newOrder
	fetch next from newOrder into @itemId, @code, @itemName, @qty, @itemPrice, @comment, @itemAmount
	print 'newOrder'
	set @count = 0
	--ITEM LESS/ADDITION CODE
	while @@FETCH_STATUS <> -1
	begin
		set @count = @count + 1
		--CHECK IF ITEM EXISTS
		if(exists (select id from Order_Detail where order_key = @orderKey and ItemId = @itemId and item_name not in (select deal_name from Deals) and item_name not in(select deal_name from DealsOnSpot)))
		begin
			print 'item exists'
			--GET DIFFERENCE IN QUANTITIES OF CURRENT QUANTITY AND SAVED QUANTITY
			set @qtyDiff = @qty - (select sum(qty) from Order_Detail where order_key = @orderKey and itemid = @itemId);

			--IF DIFFERENCE IS GREATER/LESS THAN ZERO IT IS ASSUMED ITEM QUANTITY IS CHANGED
			--THEREFORE IF @qtyDiff IS ABOVE ZERO MEANS ITEMS QUANTITY(@qty) IS GREATER (item quantity is added)
			--ELSE IF @qtyDiff IS BELOW ZERO MEANS SAVED QUANTITY VALUE(database value) IS GREATER(item quantity is reduced)
			--ELSE IF @qtyDiff IS ZERO MEANS THERE IS NO CHANGE IN ITEM QUANTIY

			--IF QUANTITY IS INCREASED
			if(@qtyDiff > 0)
			begin
				print 'item quantity added ' + cast(@qtyDiff as varchar(max))
				Insert Into OrderKot
					(orderkey, ItemId, Qty, KotStatus, Comments, Tiltid, ItemComment, LessReason, OrderDetailId)
				Select
					@OrderKey, @itemId, ABS(@qtyDiff), 0,'ADDITIONAL', @tiltId, @comment, '', (select id from order_detail where itemid = @itemid and order_key = @orderkey)

				update Order_Detail set is_additional = 1 where itemid = @itemid and order_key = @orderkey 
				update order_detail set qty = @qty, price = @itemAmount, tax = (@itemAmount * @tax), PriceBeforeDiscount = @itemAmount where order_key = @orderKey and Itemid = @itemId
			update OrderKot set ItemComment = @comment where OrderDetailId = (select id from Order_Detail where order_key = @orderKey and ItemId = @itemId)
			end
			--IF QUANTITY IS DECREASED
			else if(@qtyDiff < 0)
			begin
				print 'item quantity reduced ' + cast(@qtyDiff as varchar(max))

				Insert Into OrderKot
					(orderkey, ItemId, Qty, KotStatus, is_print, Comments, Tiltid, ItemComment, LessReason, OrderDetailId)
				Select
					@OrderKey, @itemId, ABS(@qtyDiff), 0, 0, 'LESS', @tiltId, @comment, '', (select id from order_detail where itemid = @itemid and order_key = @orderkey)

				INSERT INTO [dbo].[Item_Less]
					([id], [order_key],[date],[z_num],[category],[item],[qty],[price] ,[server] ,[order_type] ,[shift] ,[tiltId] ,[android_detail_id] ,[is_print], [od_id])
				SELECT 
					a.[order_key], a.[order_key], a.[order_date], a.[z_number], b.[category_name], b.[item_name], ABS(@qtyDiff), (ABS(@qtyDiff) * (price / qty)), a.[waiter_name], a.[order_type], GETDATE(), a.[Tiltid], a.[android_device_no], 0, b.[id]
				FROM Dine_In_Order a join order_detail b on b.[order_key] = a.[order_key] where a.[order_key] = @orderKey and b.[ItemId] = @itemId
				
			update order_detail set qty = @qty, price = @itemAmount, tax = (@itemAmount * @tax), PriceBeforeDiscount = @itemAmount where order_key = @orderKey and Itemid = @itemId
			update OrderKot set ItemComment = @comment where OrderDetailId = (select id from Order_Detail where order_key = @orderKey and ItemId = @itemId)
			end
		end
		--IF ITEM DOES NOT EXISTS MEANS IT NEEDS TO BE ADDED
		else
		begin
			print 'item not exists'
			Insert into Order_Detail
				(order_key, date, z_number, category_name, item_name, qty, price, tiltId, CounterId, Discount, PricebeforeDiscount, ItemId, tax, unit, is_additional)
			Select 
				@OrderKey, cast(@orderDate as date), @znumber, (select category_name from ItemPOS where codes = @code), @itemName, @qty, @itemAmount, @tiltId, @counterId, '0', @itemAmount, @itemid, (@itemAmount * @tax), (select Unit from itempos where codes = @code), 1

				Insert Into OrderKot
				(orderkey, ItemId, Qty, KotStatus, Comments, Tiltid, ItemComment, LessReason, OrderDetailId)
			Select
				@OrderKey, @itemId, @qty, 0,'NEW', @tiltId, @comment, '',(select id from order_detail where itemid = @itemid and order_key = @orderkey)

			Update Order_Detail set is_additional = 1 where order_key = @orderKey and Itemid = @itemId
		end
		print @count
		fetch next from newOrder into @itemId, @code, @itemName, @qty, @itemPrice, @comment, @itemAmount
	end
	close newOrder
	deallocate newOrder
	print 'newOrder cursor deallocated'
	print 'count: ' + cast(@count as varchar(max))

	----------------------------------------------------------------------------------------------------------------

--IF AN ITEM IS DELETED IT CAN ONLY BE VERIFIED BY COMPARING THE SAVED ORDER WITH CURRENT ORDER
	declare 
		@oldItemId varchar(50),
		@oldQty int,
		@orderDetailId int
	print 'declaring oldItems cursor'
	declare oldItems cursor local for select id, itemid, qty from order_detail where order_key = @orderKey and item_name not in (select deal_name from deals) and item_name not in (select deal_name from DealsOnSpot)
	open oldItems
	fetch next from oldItems into @orderDetailId, @oldItemId, @oldQty
	print 'oldItems'
	set @count = 0
		while @@FETCH_STATUS <> -1
		begin
			set @count = @count + 1
			if(not exists 
				(select c.value('@Name', 'varchar(100)') From @xml.nodes('Order/Items/MenuItem') as t(c) 
				where c.value('@Id', 'varchar(50)') = @oldItemId))
			begin
				print 'item deleted'
				INSERT INTO [dbo].[Item_Less]
					([id], [order_key],[date],[z_num],[category],[item],[qty],[price] ,[server] ,[order_type] ,[shift] ,[tiltId] ,[android_detail_id] ,[is_print])
				SELECT 
					b.[id], a.[order_key], a.[order_date], a.[z_number], b.[category_name], b.[item_name], b.[qty], b.[price], a.[waiter_name], a.[order_type], GETDATE(), a.[Tiltid], a.[android_device_no], 0
				FROM Dine_In_Order a join order_detail b on b.[order_key] = a.[order_key] 
				where a.[order_key] = @orderKey and b.[ItemId] = @oldItemId
		
				insert into orderKot
					(orderKey, comments, itemcomment, kotStatus, is_print, orderdetailid, itemid, qty, Tiltid)
				select 
					@orderKey, 'LESS', '', 0, 0, @orderDetailId, @oldItemid, @oldQty, @tiltId
				delete from Order_Detail where [order_key] = @orderKey and [ItemId] = @oldItemId
			end
			print @count
			fetch next from oldItems into @orderDetailId, @oldItemId, @oldQty
		end
	close oldItems
	deallocate oldItems
	print 'oldItems cursor deallocated'
	print 'count: ' + cast(@count as varchar(max))


	exec uspApiUpdateFixedDeals @xml
	exec uspApiUpdateOnSpotDeals @xml
end
commit
SELECT @@ROWCOUNT
end try
begin catch
	rollback
	print 'error line: ' + cast(ERROR_LINE() as varchar(max))
	print 'error message: ' + cast(ERROR_MESSAGE() as varchar(max))
	print 'final count: ' + cast(@count as varchar(max))

	--SAFELY CLOSING CURSORS ON ERROR
	begin try
		close newOrder
		deallocate newOrder
	end try
	begin catch
		print 'newOrder cursor was never alterd'
	end catch

	begin try
		close oldItems
		deallocate oldItems
	end try
	begin catch
		print 'oldItems cursor was never alterd'
	end catch

select -1
end catch