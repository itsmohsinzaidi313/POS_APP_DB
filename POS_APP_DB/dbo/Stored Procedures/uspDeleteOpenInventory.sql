CREATE proc [dbo].[uspDeleteOpenInventory]
as
Declare @OpenInvId int ;
select @OpenInvId = isnull(max(OpenInvId),0) from OpenInventoryMaster
delete from Warehouse_Store where OpenInvId > 0 
Update OpenInventoryMaster set [Type] = 'Delete' where OpenInvId = @OpenInvId
select @OpenInvId