CREATE Proc [dbo].[GetMainStoreAutoDemandSheet]--115
@Sid as int
as
Select i.ItemId,i.Item,u.Unit,u.UId,
isnull(
ipl.Parlevel - (Select (
( Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='In' and ItemId=i.ItemId and SId=@Sid)
 -
( Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='Out' and ItemId=i.ItemId  and SId=@Sid ))),0)
as DemandQty


From Item i 
inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.PurUnit=u.Uid 
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId

where ipl.BRId=0 and ipl.SId=@Sid and sc.SubCategory<>'Sub Recipe'

group by i.ItemId,i.Item,u.Unit,u.UId ,ipl.Parlevel
order by i.Item




