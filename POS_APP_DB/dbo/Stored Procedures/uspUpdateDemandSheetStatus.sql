
CREATE proc [dbo].[uspUpdateDemandSheetStatus]
@ItemId as int,
@DSCOId as int,
@POQty as decimal(18,2)
as
update DemandSheetDetail_Store set POQty = @POQty where ItemId = @ItemId and DSCOId = @DSCOId