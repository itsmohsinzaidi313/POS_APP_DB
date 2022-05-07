CREATE Proc [dbo].[ItemStoreParlevel]
@SId as int
as
select i.ItemId, i.Item , Parlevel, IPL.BRId,IPL.SId from Item i 
inner join ItemParLevel IPL on IPL.ItemId=i.ItemId
where IPL.SId=@SId and BRId=0

