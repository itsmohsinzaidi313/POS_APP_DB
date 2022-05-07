CREATE proc [dbo].[GetPONo]
@VId as int
as
select POId,PONo from PurchaseOrderMaster_Store where Status=0 and VId=@VId
order by PONo



