Create proc [dbo].[SetItemParlevelBranch]
@BRId as int
as
select IPL.BRId,IPL.SId, i.ItemId, i.Item , Parlevel from Item i 
inner join ItemParLevel IPL on IPL.ItemId=i.ItemId
where BRId=@BRId
