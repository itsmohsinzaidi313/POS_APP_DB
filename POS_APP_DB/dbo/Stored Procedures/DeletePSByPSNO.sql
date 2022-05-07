CREATE Proc [dbo].[DeletePSByPSNO]
@PSNO as nvarchar(50),
@PSId as int
as
declare @Error as nvarchar(max);
set @Error='Not Deleted'
if @PSId >0
begin
declare @PSNum as nvarchar(50);
set @PSNum='0';
Select @PSNum=PSNO from PhysicalStockMaster_Store where PSNO=@PSNO and PSId=@PSId
if @PSNum=@PSNO
begin
Delete from PhysicalStockDetail_Store where  PSId=@PSId
Delete from PhysicalStockMaster_Store  where PSNO=@PSNO and PSId=@PSId
set @Error='Deleted Successfully'
end
end
select @Error






