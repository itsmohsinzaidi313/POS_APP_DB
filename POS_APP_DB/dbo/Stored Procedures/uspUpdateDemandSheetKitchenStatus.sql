
CREATE proc [dbo].[uspUpdateDemandSheetKitchenStatus]
@ItemId as int,
@DSId as int,
--@Status as bit
@IssQty as decimal(18,2)
as
update DemandSheetDetail_Branch set IssQty = @IssQty where ItemId = @ItemId and DSId = @DSId



