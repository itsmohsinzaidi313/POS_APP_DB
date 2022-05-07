CREATE Proc [dbo].[DeletePOByPONo]
@PONo as nvarchar(50),
@POId as int
as
declare @Error as nvarchar(max);
set @Error='Not Deleted'
if @POId >0
begin
declare @PONum as nvarchar(50);
set @PONum='0';
Select @PONum=PONo from PurchaseOrderMaster_Store where PONo=@PONo and POId=@POId
if @PONum=@PONo
begin
Delete from PurchaseOrderDetail_Store where  POId=@POId
Delete from PurchaseOrderMaster_Store  where PONo=@PONo and POId=@POId
set @Error='Deleted Successfully'
end
end
select @Error






