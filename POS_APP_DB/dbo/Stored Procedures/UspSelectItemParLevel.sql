CREATE proc [dbo].[UspSelectItemParLevel]
@ItemId as int
as
select ItemParLevel.id, BRId, ParLevel,SId,DId from ItemParLevel
where ItemId=@ItemId
