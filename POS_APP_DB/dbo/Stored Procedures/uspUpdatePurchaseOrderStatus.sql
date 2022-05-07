
CREATE proc [dbo].[uspUpdatePurchaseOrderStatus]
@ItemId as int,
@POId as int,
--@Status as bit
@RecQty as decimal(18,2)
as
update PurchaseOrderDetail_Store set RecQty = @RecQty where ItemId = @ItemId and POId = @POId