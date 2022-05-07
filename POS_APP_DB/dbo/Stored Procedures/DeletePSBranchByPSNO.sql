CREATE Proc [dbo].[DeletePSBranchByPSNO]
@PSNO as nvarchar(50),
@PSBRId as int
as
declare @Error as nvarchar(max);
set @Error='Not Deleted'
if @PSBRId >0
begin
declare @PSNum as nvarchar(50);
set @PSNum='0';
Select @PSNum=PSNO from PhysicalStockMaster_Branch where PSNO=@PSNO and PSBRId=@PSBRId
if @PSNum=@PSNO
begin
Delete from PhysicalStockDetail_Branch where  PSBRId=@PSBRId
Delete from PhysicalStockMaster_Branch  where PSNO=@PSNO and PSBRId=@PSBRId
set @Error='Deleted Successfully'
end
end
select @Error







