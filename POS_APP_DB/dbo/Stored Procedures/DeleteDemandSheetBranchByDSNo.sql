create Proc [dbo].[DeleteDemandSheetBranchByDSNo]
@DSNo as nvarchar(50),
@DSId as int
as
declare @Error as nvarchar(max);
set @Error='Not Deleted'
if @DSId >0
begin
declare @DSNum as nvarchar(50);
set @DSNum='0';
Select @DSNum=DSNo from DemandsheetMaster_Branch where DSNo=@DSNo and DSId=@DSId
if @DSNum=@DSNo
begin
Delete from DemandsheetDetail_Branch where  DSId=@DSId
Delete from DemandsheetMaster_Branch  where DSNo=@DSNo and DSId=@DSId
set @Error='Deleted Successfully'
end
end
select @Error




