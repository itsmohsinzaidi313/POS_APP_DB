Create proc [dbo].[UspSelectPurchaseOrder]
as
select POId,Date,PONo from PurchaseOrderMaster_Store
order by PONo