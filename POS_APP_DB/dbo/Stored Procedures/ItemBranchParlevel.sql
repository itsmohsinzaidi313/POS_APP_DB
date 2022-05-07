
CREATE Proc [dbo].[ItemBranchParlevel]--44
@BRId as int
as
select i.ItemId,i.Item , ISNULL (SUM(Parlevel),0) AS Parlevel ,IPL.BRId,IPL.SId from Item i 
inner join ItemParLevel IPL on IPL.ItemId=i.ItemId
where IPL.BRId=@BRId  and SId=0
GROUP BY 
 i.ItemId, i.Item,IPL.BRId,IPL.SId

--select * from ItemParlevel
--select i.ItemId, i.Item , Parlevel,IPL.BRId,IPL.SId from Item i 
--inner join ItemParLevel IPL on IPL.ItemId=i.ItemId
--where IPL.BRId=@BRId  and SId=0
