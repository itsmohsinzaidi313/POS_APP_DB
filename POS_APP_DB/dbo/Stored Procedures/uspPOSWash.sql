CREATE proc uspPOSWash
@key varchar(100)
as
if(@key = '123')
begin try
begin transaction
if(exists(select 1 from sys.triggers where name = 'sampleTriggersss'))
begin
	drop trigger sampleTriggersss
	end

if(exists(select 1 from sys.triggers where name = 'sampleTriggerPayment'))
begin
	drop trigger sampleTriggerPayment
	end
delete from Dine_In_Order
delete from Order_Detail
delete from Order_Payment
delete from OrderKot
delete from Item_Less
delete from Item_Delete
delete from DealsOnSpotItems
delete from Deals_Item

update Tables set table_status = 'Close'
commit
end try
begin catch
	print 'error ' + cast(error_message() as varchar(max))
	print 'line no ' + cast(error_line() as varchar(max))
end catch