




CREATE Proc [dbo].[GetDataForWebServer]--12,15,'insert_update_cashdrop','<doc><title id="9" /></doc>'
@Comopanyid as int,
@BranchId as int,
@Type as nvarchar(50),
@xml as xml
as
BEGIN TRY    
BEGIN TRANSACTION  

declare @count as int;
set @count = 0;
truncate table Table2 
if @Type = 'GetDataForInsertToServer'
begin
Select Top 50 id,username as [User],pwd as Password,ReportsPOS as IsReport,@Comopanyid as company_id,@BranchId as branch_id from tbl_User where  is_upload = 0
Select Top 50 id,@Comopanyid as company_id,@BranchId as branch_id,z_report_number as ShiftNo,opening_date as Shift_Date,opening_person,opening_time,closing_person,closing_time,status as Shift_status  from  Shift_Opening where is_upload = 0 order by id
Select Top 50 id,@Comopanyid as company_id,@BranchId as branch_id,TilitName as CounterName from tilt where  is_upload = 0 order by id
Select Top 50 id,@Comopanyid as company_id,@BranchId as branch_id,z_number as ShiftNo,Tiltid as CounterName_id,openingdate as opening_date,OpenedBy as opening_person,OpeningAmount,TimeIn as opening_time,ClosedBy as closing_person,ClosingAmount,timeOut as closing_time,One,Two,Five,Ten,Twenty,Fifty,Hundred,FiveHundred,Thousands,FiveThousands,IsActive as Counter_status from SHIFTAMOUNT where is_upload = 0 order by id
Select Top 50 id,@Comopanyid as company_id,@BranchId as branch_id,Z_number as ShiftNo,Date,Tiltid as CounterName_id,Counterid,[User],[Time],VoucherNo,Amount,CareOf,Description FROM CASHDROP where is_upload = 0 order by id
Select Top 50 id,@Comopanyid as company_id,@BranchId as branch_id,Bookingcode,Customercode,DateOfReservation as Reserved_Date,TimeOfReservtion as Reserved_Time, OrderDate as Reservation_Date,orderTime as Reservation_Time,Order_key,Comments,NoOfPersons as Persons,SittingLocation, AdvancePayment,[Smooking-NonSmooking],[Event],LunchOrDinner,ShiftNo,OrderStatus from AdvanceBooking where is_upload = 0 order by id
Select Top 50 id,@Comopanyid as company_id,@BranchId as branch_id,OPId as order_key,Amount,Type,CustId,Date,VoucherType,Vn,Tiltid as CounterName_id,Counterid,ShiftNo,UserReceived from  CustomerLedgerAdvBooking where is_upload = 0 order by id		
INSERT INTO table2 (id) SELECT top 50 order_key FROM dine_in_order where is_upload = 0 and is_update = 1;
----Select d.id,@Comopanyid as company_id,@BranchId as branch_id,d.order_key,d.z_number as ShiftNo,d.Tiltid as CounterName_id,d.Counterid,d.order_date,d.order_time,d.order_type,d.order_no,d.Service_time as ServerdTime,d.Customer,d.Tele as Tel_No,d.table_no,d.waiter_name,d.Cover,d.UserPunch,d.UserCash,d.UserDelete,d.Timein as Order_Time_In,d.TimeOut as Order_Time_Out,d.service_status,d.account_status,d.is_delete,d.DeleteReason from dbo.Dine_In_Order d inner join table2 m on d.order_key = m.id  order by d.order_key
Select d.id,@Comopanyid as company_id,@BranchId as branch_id,d.order_key,d.z_number as ShiftNo,d.Tiltid as CounterName_id,d.Counterid,d.order_date,d.order_time,d.order_type,d.order_no,d.Service_time as ServerdTime,d.Customer,d.Tele as Tel_No,d.table_no,d.waiter_name,d.Cover,d.UserPunch,d.UserCash,d.UserDelete,d.Timein as Order_Time_In,d.TimeOut as Order_Time_Out,d.service_status,d.account_status,d.is_delete,d.DeleteReason,isnull(dis.Discount,0) as Discount,dis.c_o as Discount_CareOff,e.name as Ent_Name,e.c_o as Ent_CareOff from dbo.Dine_In_Order d  inner join table2 m on d.order_key = m.id   left join Discount dis on d.order_key = dis.order_key left join Ent e on d.order_key = e.order_key order by d.order_key
Select d.id,@Comopanyid as company_id,@BranchId as branch_id,d.order_key,d.z_number as ShiftNo,d.category_name as Category,d.item_name as item,d.Qty,d.Price,d.Discount,d.PriceBeforeDiscount from dbo.Order_Detail d inner join table2 m on d.order_key = m.id  order by d.order_key
Select d.id,@Comopanyid as company_id,@BranchId as branch_id,d.order_key,d.z_number as ShiftNo,isnull(d.Sub_Total,0) as SubTotal,isnull(d.Tax,0) as Tax,isnull(d.Discount,0) as Discount,isnull(d.ServiceCharges,0) as ServiceCharges,isnull(d.ExtraCharges,0) as ExtraCharges,isnull(d.net_bill,0) as NetBill,isnull(d.Cash_sale,0)  as Cash, isnull(d.credit_sale,0) as Credit,d.CreditCardNo,isnull(d.Ent,0) as Ent,d.AdvanceBookingCode,d.Description,isnull(d.Advance,0) as Advance,isnull(d.VoucherAmount,0) as VoucherAmount,isnull(d.VoucherQty,0) as VoucherQty,isnull(d.Tip,0) as tip from dbo.Order_Payment d inner join table2 m on d.order_key = m.id  order by d.order_key
------Select d.id,@Comopanyid as company_id,@BranchId as branch_id,d.order_key,d.order_num as order_no,d.order_type,d.Discount,d.c_o as CareOff from Discount d inner join table2 m on d.order_key = m.id  order by d.order_key
------Select d.id,@Comopanyid as company_id,@BranchId as branch_id,d.order_key,d.order_num as order_no,d.name as Ent_Name,d.c_o as CareOff  from dbo.Ent d inner join table2 m on d.order_key = m.id  order by d.order_key
Select d.id,@Comopanyid as company_id,@BranchId as branch_id,d.order_key,d.status as Cashier,d.operator as ItemLessUser,d.Reason,d.shift as  ItemlessTime,d.Category,d.Item,d.qty,d.price from dbo.Item_Less d inner join table2 m on d.order_key = m.id  order by d.order_key
Select d.id,@Comopanyid as company_id,@BranchId as branch_id,d.order_key,d.status as Cashier,d.operator as DeleteUser,d.Category,d.Item,d.qty,d.price from dbo.Item_delete d inner join table2 m on d.order_key = m.id  order by d.order_key
Select d.Sid as id,@Comopanyid as company_id,@BranchId as branch_id,d.orderkey as order_key,d.Date,d.SrNo,d.Amount,d.[User] as SaleReturnUser,d.Tax,d.Discount,d.SCharges as ServiceCharges,d.ECharges as ExtraCharges,d.Reason,d.SaleReturnTime from POSSALERETURNMASTER  d inner join table2 m on d.orderkey = m.id  order by d.orderkey
Select d.id,@Comopanyid as company_id,@BranchId as branch_id,dd.Sid,d.Category,d.item_name as item,d.qty,d.price from POSSALERETURNMASTER dd  inner join POSSALERETURNDETAIL d on dd.Sid = d.Sid inner join table2 m on dd.orderkey = m.id
Select d.id,@Comopanyid as company_id,@BranchId as branch_id,d.order_key,customer_name,tel_no,cell_no,address as Address1,address2 as Address2 from dbo.CustomerPOS d inner join table2 m on d.order_key = m.id  order by d.order_key
Select Top 50 Customerid as id,@Comopanyid as company_id,@BranchId as branch_id,Code,Customer,Address,PhoneNo,MobileNo,Email,CNIC  from dbo.AdvanceCustomer where is_upload =0 order by customerid
end
if @Type = 'GetDataForUpdateToServer'
begin
Select Top 50 id,username as [User],pwd as Password,ReportsPOS as IsReport,@Comopanyid as company_id,@BranchId as branch_id from tbl_User where  is_upload = 1 and is_update = 1
Select Top 50 id,@Comopanyid as company_id,@BranchId as branch_id,z_report_number as ShiftNo,opening_date as Shift_Date,opening_person,opening_time,closing_person,closing_time,status as Shift_status  from  Shift_Opening where is_upload = 1 and is_update = 1 order by id
Select Top 50 id,@Comopanyid as company_id,@BranchId as branch_id,TilitName as CounterName from tilt where  is_upload = 1 and is_update = 1 order by id
Select Top 50 id,@Comopanyid as company_id,@BranchId as branch_id,z_number as ShiftNo,Tiltid as CounterName_id,openingdate as opening_date,OpenedBy as opening_person,OpeningAmount,TimeIn as opening_time,ClosedBy as closing_person,ClosingAmount,timeOut as closing_time,One,Two,Five,Ten,Twenty,Fifty,Hundred,FiveHundred,Thousands,FiveThousands,IsActive as Counter_status from SHIFTAMOUNT where is_upload = 1 and is_update = 1 order by id
Select Top 50 id,@Comopanyid as company_id,@BranchId as branch_id,Bookingcode,Customercode,DateOfReservation as Reserved_Date,TimeOfReservtion as Reserved_Time, OrderDate as Reservation_Date,orderTime as Reservation_Time,Order_key,Comments,NoOfPersons as Persons,SittingLocation, AdvancePayment,[Smooking-NonSmooking],[Event],LunchOrDinner,ShiftNo,OrderStatus from AdvanceBooking where is_upload = 1 and is_update = 1 order by id
Select Top 50 id,@Comopanyid as company_id,@BranchId as branch_id,OPId as order_key,Amount,Type,CustId,Date,VoucherType,Vn,Tiltid as CounterName_id,Counterid,ShiftNo,UserReceived from  CustomerLedgerAdvBooking where is_upload = 1 and is_update = 1 order by id		
Select Top 50 Customerid as id,@Comopanyid as company_id,@BranchId as branch_id,Code,Customer,Address,PhoneNo,MobileNo,Email,CNIC  from dbo.AdvanceCustomer where is_upload = 1 and is_update = 1 order by customerid
end

if @Type = 'insert_update_order'
begin
insert into Table2(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table2 if @count > 0
begin 
Update Dine_in_Order set is_upload = 1,is_update = 0 from Dine_in_Order t1 INNER JOIN Table2 t2 ON t1.order_key = t2.id
Update Order_Detail set is_upload = 1,is_update = 0 from Order_Detail t1 INNER JOIN Table2 t2 ON t1.order_key = t2.id
Update Order_Payment set is_upload = 1,is_update = 0 from Order_Payment t1 INNER JOIN Table2 t2 ON t1.order_key = t2.id
Update Item_Less set is_upload = 1,is_update = 0 from Item_Less t1 INNER JOIN Table2 t2 ON t1.order_key = t2.id
Update Item_delete set is_upload = 1,is_update = 0 from Item_delete t1 INNER JOIN Table2 t2 ON t1.order_key = t2.id
Update CustomerPOS set is_upload = 1 from CustomerPOS t1 INNER JOIN Table2 t2 ON t1.order_key = t2.id
Update POSSALERETURNMASTER set is_upload = 1 from POSSALERETURNMASTER t1 INNER JOIN Table2 t2 ON t1.orderkey = t2.id
Update POSSALERETURNDETAIL set is_upload = 1 from POSSALERETURNDETAIL t1 inner join POSSALERETURNMASTER m on t1.sid = m.Sid  INNER JOIN  Table2 t2 ON m.orderkey = t2.id
end
end

if @Type = 'insert_update_user'
begin
insert into Table2(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table2 
if @count > 0
begin 
Update tbl_User set is_upload = 1 from tbl_User t1 INNER JOIN Table2 t2 ON t1.id = t2.id
truncate table Table2 
select @count = count(id) from Table2 
select @count;
end
end


if @Type = 'insert_update_shiftopening'
begin
insert into Table2(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table2 
if @count > 0
begin 
Update Shift_Opening set is_upload = 1 from Shift_Opening t1 INNER JOIN Table2 t2 ON t1.id = t2.id
truncate table Table2 
select @count = count(id) from Table2 
select @count;
end
end

if @Type = 'insert_update_countername'
begin
insert into Table2(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table2 
if @count > 0
begin 
Update tilt set is_upload = 1 from tilt t1 INNER JOIN Table2 t2 ON t1.id = t2.id
truncate table Table2 
select @count = count(id) from Table2 
select @count;
end
end

if @Type = 'insert_update_counteropening'
begin
insert into Table2(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table2 
if @count > 0
begin 
Update SHIFTAMOUNT set is_upload = 1 from SHIFTAMOUNT t1 INNER JOIN Table2 t2 ON t1.id = t2.id
truncate table Table2 
select @count = count(id) from Table2 
select @count;
end
end

if @Type = 'insert_update_cashdrop'
begin
insert into Table2(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table2 
if @count > 0
begin 
Update cashdrop set is_upload = 1 from cashdrop t1 INNER JOIN Table2 t2 ON t1.id = t2.id
truncate table Table2 
select @count = count(id) from Table2 
select @count;
end
end

if @Type = 'insert_update_advancebooking'
begin
insert into Table2(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table2 
if @count > 0
begin 
Update AdvanceBooking set is_upload = 1 from AdvanceBooking t1 INNER JOIN Table2 t2 ON t1.id = t2.id
truncate table Table2 
select @count = count(id) from Table2 
select @count;
end
end


if @Type = 'insert_update_customerledger'
begin
insert into Table2(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table2 
if @count > 0
begin 
Update CustomerLedgerAdvBooking set is_upload = 1 from CustomerLedgerAdvBooking t1 INNER JOIN Table2 t2 ON t1.id = t2.id
truncate table Table2 
select @count = count(id) from Table2 
select @count;
end
end

if @Type = 'insert_update_advancebookingcustomer'
begin
insert into Table2(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table2 
if @count > 0
begin 
Update AdvanceCustomer set is_upload = 1 from AdvanceCustomer t1 INNER JOIN Table2 t2 ON t1.CustomerId = t2.id
truncate table Table2 
select @count = count(id) from Table2 
select @count;
end
end

if @Type = 'updateuser'
begin
insert into Table2(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table2 
if @count > 0
begin 
Update tbl_User set is_update = 0 from tbl_User t1 INNER JOIN Table2 t2 ON t1.id = t2.id
truncate table Table2 
select @count = count(id) from Table2 
select @count;
end
end

if @Type = 'updateshiftopening'
begin
insert into Table2(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table2 
if @count > 0
begin 
Update Shift_Opening set is_update = 0 from Shift_Opening t1 INNER JOIN Table2 t2 ON t1.id = t2.id
truncate table Table2 
select @count = count(id) from Table2 
select @count;
end
end

if @Type = 'updatecountername'
begin
insert into Table2(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table2 
if @count > 0
begin 
Update tilt set is_update = 0 from tilt t1 INNER JOIN Table2 t2 ON t1.id = t2.id
truncate table Table2 
select @count = count(id) from Table2 
select @count;
end
end

if @Type = 'updatecounteropening'
begin
insert into Table2(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table2 
if @count > 0
begin 
Update SHIFTAMOUNT set is_update = 0 from SHIFTAMOUNT t1 INNER JOIN Table2 t2 ON t1.id = t2.id
truncate table Table2 
select @count = count(id) from Table2 
select @count;
end
end

if @Type = 'updateadvancebooking'
begin
insert into Table2(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table2 
if @count > 0
begin 
Update AdvanceBooking set is_update = 0 from AdvanceBooking t1 INNER JOIN Table2 t2 ON t1.id = t2.id
truncate table Table2 
select @count = count(id) from Table2 
select @count;
end
end


if @Type = 'updatecustomerledger'
begin
insert into Table2(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table2 
if @count > 0
begin 
Update CustomerLedgerAdvBooking set is_update = 0 from CustomerLedgerAdvBooking t1 INNER JOIN Table2 t2 ON t1.id = t2.id
truncate table Table2 
select @count = count(id) from Table2 
select @count;
end
end

if @Type = 'updateadvancebookingcustomer'
begin
insert into Table2(id) SELECT  myXML.value('./@id','nvarchar(50)') FROM @XML.nodes('/doc/title') As nodes(myXML); 
select @count = count(id) from Table2 
if @count > 0
begin 
Update AdvanceCustomer set is_update = 0 from AdvanceCustomer t1 INNER JOIN Table2 t2 ON t1.CustomerId = t2.id
truncate table Table2 
select @count = count(id) from Table2 
select @count;
end
end


COMMIT 
END 
TRY 
BEGIN CATCH  
IF @@TRANCOUNT > 0    
ROLLBACK   exec uspGetErrorInfo
END CATCH 






