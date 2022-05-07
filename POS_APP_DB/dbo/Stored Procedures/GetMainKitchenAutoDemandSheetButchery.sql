Create Proc [dbo].[GetMainKitchenAutoDemandSheetButchery]--25
@BRId as int
as
Select i.ItemId,i.Item,u.Unit,u.UId,
isnull(
ipl.Parlevel - 
--(Select isnull(sum(Parlevel),0) from ItemParlevel where ItemId=i.ItemId and BRId=@BRId and SId=0)-
(Select 
( Select isnull(Sum(Qty),0) from WareHouse_Branch where [Type]='In' and ItemId=i.ItemId and BRId=@BRId)
 -
( Select isnull(Sum(Qty),0) from WareHouse_Branch where [Type]='Out' and ItemId=i.ItemId  and BRId=@BRId )),0)
as DemandQty
From Item i 
inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join Unit u on iu.IssUnit=u.Uid 
inner join Butchery bu on bu.Id=i.[Type] 
where ipl.BRId=@BRId and ipl.SId=0  and sc.SubCategory<>'Sub Recipe'
and bu.ItemType='Butchery'
group by i.ItemId,i.Item,u.Unit,u.UId,ipl.Parlevel
order by i.Item

