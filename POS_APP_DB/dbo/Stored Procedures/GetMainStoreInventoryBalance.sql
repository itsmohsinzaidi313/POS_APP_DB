

CREATE Proc [dbo].[GetMainStoreInventoryBalance]--115
@Sid as int
as
Select i.ItemId,i.Item,u.Unit,u.UId,ipl.Parlevel,
(Select (
( Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='In' and ItemId=i.ItemId and SId=@Sid  )
 -
( Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='Out' and ItemId=i.ItemId  and SId=@Sid )))as Balance

--cast((Select
--left(
--(Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='In' and ItemId=i.ItemId and SId=@Sid  )
-- -
--(Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='Out' and ItemId=i.ItemId  and SId=@Sid ),
--len((Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='In' and ItemId=i.ItemId and SId=@Sid  )
-- -
--(Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='Out' and ItemId=i.ItemId  and SId=@Sid ))-2
--)) as decimal(18,2))as Balance
From Item i 
inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.PurUnit=u.Uid 
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
where ipl.Sid=@Sid  and ipl.BRId=0 and sc.SubCategory<>'Sub Recipe'
order by i.Item




