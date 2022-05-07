CREATE  proc [dbo].[uspDeleteOpenInventoryDepartment]
@Did  as int
as
Declare @OpenInvId int ;
select @OpenInvId = isnull(max(OpenInvId),0) from OpenInventoryMaster_department where DId = @Did
delete from Warehouse_Branch where  OpenInvId > 0  and DId = @Did
Update OpenInventoryMaster_department set [Type] = 'Delete' where OpenInvId = @OpenInvId
select @OpenInvId