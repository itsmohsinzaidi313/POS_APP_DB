CREATE proc [dbo].[uspApiInsertOrder]
@xml xml
as
begin try
begin transaction
declare
	@covers as int, 
	@orderType as int, 
	@orderTypeTxt as varchar(50),
	@znumber as varchar(20),
	@counterId as int, 
	@userid as int,
	@orderNo int,
	@orderid varchar(25),
	@waiterNo as varchar(50), 
	@tableId as varchar(50), 
	@orderDate as date,
	@orderTime as varchar(50),
	@amount as decimal(18,2),
	@tax as decimal(18,2),
	@tiltId as int,
	@customer as varchar(50),
	@contact as varchar(50),
	@address as varchar(max),
	@time as time,
	@tokenNo as varchar(50)

select 
@covers = c.value('@Covers','int'),
@orderType = c.value('@OrderType','int'),
@counterId = (select top 1 id from ShiftAmount where IsActive = 1 order by id desc),
@userid = c.value('@UserId','int'),
@tiltId = c.value('@TiltId','int'),
@waiterNo = c.value('@Waiter','varchar(50)'),
@tableId = c.value('@Table','varchar(50)'),
@orderDate = c.value('@Date','date'),
@orderTime = c.value('@Time','varchar(10)'),
@amount = c.value('@Amount','float'),
@znumber = (select z_report_number from Shift_Opening where status = 1),
@tax = (select isnull((tax_amount / 100),1) from tax where isApplicable = 1),
@time =  CAST(getdate() AS time),
@orderNo = (select isnull(count(id), 0) + 1 from Dine_In_Order),
@tokenNo = (select isnull(count(order_key), 0) + 1 from Dine_In_Order where order_date =  DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE()))),
@orderId = (@userid + '' + (SELECT CONVERT(VARCHAR(10), SYSDATETIME(),12)) + '' + CONVERT(varchar(10), @userid) + CONVERT(varchar(10), @orderNo) + '-' + Convert(varchar(10), @userId))
from @xml.nodes('/Order') as t(c)

select 
	@customer = c.value('@Name','varchar(50)'),
	@contact = c.value('@Contact','varchar(50)'),
	@address = c.value('@Address','varchar(50)')
	from @xml.nodes('/Order/Customer') as t(c)

if(@orderType = 1)
begin
	set @orderTypeTxt = 'DINE IN'
end
else if(@orderType =  2)
begin
	set @orderTypeTxt = 'TAKE AWAY'
end
else if(@orderType = 3)
begin
	set @orderTypeTxt = 'DELIVERY'
end
insert into Dine_In_Order
		(order_key, z_number, order_type, order_no, order_date, [day], table_no, waiter_name, order_time, service_status, account_status, TiltId, UserPunch, Od, CounterId, TabUserPunch, cover, new_order_no, OrderStatus, android_device_no, [user_id], amount, Customer, Tele, tab_unique_id, TokenNumber)

	values
		('0', @znumber, @orderTypeTxt, @orderNo, cast(@orderDate as date), datename(dw,DATEADD(dd, 0, DATEDIFF(dd, 0, cast(@orderDate as date)))), (select [Tables] from [Tables] where id = @tableId), (select waiter_name from waiter where id_ = @waiterNo), @orderTime, 'SERVED', 'Not Paid', @tiltId, (select username from tbl_user where id = @userid), @orderNo, @counterId, @waiterNo, @covers, @orderid,  'COMPLETE', @userid, @userid, @amount, @customer, @contact, @tiltId, @tokenNo)
print 'dine_in_order inserted'
declare @OrderKey as varchar(100)
set @OrderKey = @@IDENTITY
if(@OrderKey > 0)
begin
	Update Dine_In_Order set order_key = @OrderKey where id = @OrderKey
	print 'dine_in_order updated'
	
	if(@orderType = 1)
	begin
		update [tables] set [table_status] = 'Open' where [id] = @tableId
		print 'tables inserted'
	end
	else if(@orderType = 2)
	begin
		insert into CustomerPOS(order_key, customer_name, cell_no)
		select @OrderKey, @customer, @contact
	end
	else if(@orderType = 3)
	begin
		insert into CustomerPOS(order_key, customer_name, cell_no, [address])
		select @OrderKey, @customer, @contact, @address
	end
	--ITEMS INSERTION
	print 'inserting items'
	Insert into Order_Detail
		(order_key, date, z_number, category_name, item_name, qty, price, tiltId, CounterId, Discount, PricebeforeDiscount, ItemId, tax, unit)
	Select 
		@OrderKey, 
		cast(@orderDate as date), 
		@znumber, 
		(select category_name from ItemPOS where id = c.value('@Id','int')), 
		c.value('@Name', 'varchar(100)'), 
		c.value('@Quantity', 'float'), 
		(t.c.value('@Price','float') * t.c.value('@Quantity','float')), 
		@tiltId,
		@counterId, 
		'0', 
		(c.value('@Price','float') * c.value('@Quantity', 'float')), 
		c.value('@Id', 'varchar(50)'), 
		((c.value('@Price','float') * c.value('@Quantity', 'float')) * @tax), 
		(select Unit from itempos where id = c.value('@Id','int'))
	From @xml.nodes('Order/Items/MenuItem') as t(c) 
	
	print 'inserting in items orderkot'
	Insert Into OrderKot
		(orderkey,ItemId,Qty,KotStatus,Comments,Tiltid,ItemComment,LessReason,OrderDetailId)
	Select
		@OrderKey, c.value('@Id', 'varchar(50)'), c.value('@Quantity', 'float'),0, 'NEW', @tiltId, c.value('@Comment', 'varchar(50)'), '', (select id from order_detail where order_key = @OrderKey and ItemId = c.value('@Id', 'varchar(50)'))
	From @xml.nodes('/Order/Items/MenuItem') as t(c)

	exec uspApiInsertFixedDeals @orderKey, @xml
	exec uspApiInsertOnSpotDeals @orderKey, @xml

end
commit
SELECT @OrderKey
end try
begin catch
rollback
print 'error ' + cast(error_message() as varchar(max))
print 'line no ' + cast(error_line() as varchar(max))
select -1
end catch