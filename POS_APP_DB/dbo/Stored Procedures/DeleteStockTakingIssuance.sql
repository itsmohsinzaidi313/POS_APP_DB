CREATE Proc [dbo].[DeleteStockTakingIssuance]
@PSNO as nvarchar(50),
@PSId as int
as

BEGIN TRY
   BEGIN TRANSACTION  

declare @Error as nvarchar(max);
set @Error='Not Deleted'
if @PSId >0
begin

Declare @IssId as int;
Declare @IssNo as nvarchar(50);
set @IssNo = '';
set @IssId = 0;
select @IssId = IssId
--,@IssNo = IssNo 
from IssuanceMaster_Store where PSId = @PSId

declare @PSNum as nvarchar(50);
set @PSNum='0';
Select @PSNum=PSNO from PhysicalStockMaster_Store where PSNO=@PSNO and PSId=@PSId
if @PSNum=@PSNO
begin
--execute [DeleteIssuanceStore]@IssId,@IssNo
Delete from IssuanceDetail_Store where IssId = @IssId
Delete from IssuanceMaster_Store where IssId = @IssId
Delete from WareHouse_Store where IssId = @IssId
Delete from WareHouse_Branch where IssId = @IssId


   COMMIT

Delete from PhysicalStockDetail_Store where  PSId=@PSId
Delete from PhysicalStockMaster_Store  where PSNO=@PSNO and PSId=@PSId
set @Error='Deleted Successfully'
end
end


END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
exec uspGetErrorInfo
END CATCH

select @Error