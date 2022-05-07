
CREATE Proc [dbo].[DeleteTransferByTransferId]--'BranchToBranch',10
@Type as nvarchar(50),
@Tid as int
as

BEGIN TRY
   BEGIN TRANSACTION   
Declare @Count as int;
set @Count = 1;

Declare @TInMId as int;
set @TInMId = 0;
Declare @TOutMId as int;
set @TOutMId = 0;

Select @TInMId = TRIId  from TransferInMaster where TransferId = @Tid
Select @TOutMId = TRId from TransferOutMaster where TransferId = @Tid
if @TInMId > 0 and @TOutMId > 0
begin
if @Type = 'StoreToStore'
begin
Delete from  WareHouse_Store where TRInId = @TInMId
Delete from  WareHouse_Store where TROutId = @TOutMId
end
else if @Type = 'BranchToBranch'
begin
Delete from  WareHouse_branch where TRInId = @TInMId
Delete from  WareHouse_branch where TROutId = @TOutMId
end
else if @Type = 'StoreToBranch'
begin
Delete from  WareHouse_Store where TROutId = @TOutMId
Delete from  WareHouse_branch where TRInId = @TInMId
end
else if @Type = 'BranchToStore'
begin
Delete from  WareHouse_branch where TROutId = @TOutMId
Delete from  WareHouse_Store where TRInId = @TInMId
end
end
   COMMIT

Delete from TransferInDetail where TRIId = @TInMId
Delete from TransferInMaster where TransferId = @Tid
Delete from TransferOutDetail where TRId = @TOutMId
Delete from TransferOutMaster where TransferId = @Tid
Delete from Transfer where TransferId = @Tid
Select @Count = count(TransferId)  from Transfer where TransferId = @Tid

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH

Select @Count