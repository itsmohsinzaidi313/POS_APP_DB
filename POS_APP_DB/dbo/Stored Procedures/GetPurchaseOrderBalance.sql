CREATE proc [dbo].[GetPurchaseOrderBalance]
@Sid as int
as
Select i.ItemId,i.Item,u.Unit,u.UId,ipl.Parlevel,
(Select (
( Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='In' and ItemId=i.ItemId and SId=@Sid  )
 -
( Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='Out' and ItemId=i.ItemId  and SId=@Sid )))as Balance

From Item i 
inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.PurUnit=u.Uid
order by i.Item