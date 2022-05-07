create proc [dbo].[uspGetItemUnitFactorByItemId]
@ItemId as int
as
select * from ItemUnit where ItemId = @ItemId