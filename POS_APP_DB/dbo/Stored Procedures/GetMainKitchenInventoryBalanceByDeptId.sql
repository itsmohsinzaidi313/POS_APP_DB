create Proc [dbo].[GetMainKitchenInventoryBalanceByDeptId]--'62'
@BRId as int,
@DeptId as int
as
Select i.ItemId,i.Item,u.Unit,u.UId,ipl.Parlevel,
Cast(Round((Select (
( Select isnull(Sum(Qty),0) from WareHouse_Branch where [Type]='In' and ItemId=i.ItemId and BRId=@BRId and DId = @DeptId)
 -
( Select isnull(Sum(Qty),0) from WareHouse_Branch where [Type]='Out' and ItemId=i.ItemId and BRId=@BRId and DId = @DeptId))

),2) AS DECIMAL (18,2))as Balance,
Cast(Round((Select (
(select isnull(avg(Rate) ,0)from WareHouse_Branch where ItemId = i.ItemId and BRId=@BRId and DId = @DeptId))
),2) AS DECIMAL (18,2))as Rate,

Cast((Round((select isnull(IssFactor,0) from ItemUnit where ItemId = i.ItemId)
--/
--(select isnull(PurFactor,0) from ItemUnit where ItemId = i.ItemId)
,2)) AS DECIMAL (18,2)) as Factor,

iu.PurUnit as PurUnitId,(select Unit from Unit where UId = iu.PurUnit) as PurUnit
From Item i 
inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
--inner join Unit u on iu.PurUnit=u.Uid 
inner join Unit u on iu.IssUnit=u.Uid 
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
--inner join Butchery bu on bu.Id=i.[Type] 
where ipl.SId=0 and ipl.BRId=@BRId and ipl.DId = @DeptId and i.[Type]='Non Butchery'and sc.SubCategory<>'Sub Recipe'
order by i.Item 










