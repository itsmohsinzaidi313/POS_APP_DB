CREATE Proc [dbo].[DeleteDemandSheetByDSNo]
@DSNo as nvarchar(50),
@DSCOId as int
as
declare @Error as nvarchar(max);
set @Error='Not Deleted'
if @DSCOId >0
begin
declare @DSNum as nvarchar(50);
set @DSNum='0';
Select @DSNum=DSNo from DemandsheetMaster_Store where DSNo=@DSNo and DSCOId=@DSCOId
if @DSNum=@DSNo
begin
Delete from DemandsheetDetail_Store where  DSCOId=@DSCOId
Delete from DemandsheetMaster_Store where DSNo=@DSNo and DSCOId=@DSCOId
set @Error='Deleted Successfully'
end
end
select @Error



