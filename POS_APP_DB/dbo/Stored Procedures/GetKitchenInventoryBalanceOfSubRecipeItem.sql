CREATE Proc [dbo].[GetKitchenInventoryBalanceOfSubRecipeItem]--81
@Sid as int
as
--Select i.ItemId,i.Item,u.Unit,u.UId,ipl.Parlevel,(Select
----(
----(Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='In' and ItemId=i.ItemId and SId=@Sid  )
---- -
----(Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='Out' and ItemId=i.ItemId  and SId=@Sid )))as Balance,
----(select Cast(isnull(Round(avg(Rate),2),0) AS DECIMAL (18,2)) from WareHouse_Store where ItemId=i.ItemId  and SId=@Sid) as Rate
----From Item i 
----inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
----inner join ItemUnit iu on i.ItemId=iu.ItemId
----inner join Unit u on iu.PurUnit=u.Uid 
----inner join SubCategory s on i.SBId=s.SBID
----where 
----ipl.Sid = @SId and ipl.BRId=0 and s.SubCategory like 'Sub%'
----group by i.ItemId,i.Item,u.Unit,u.UId,ipl.Parlevel
----order by i.Item
----

Select i.ItemId,i.Item,
u.Unit,
u.UId,
ipl.Parlevel,

Cast(Round(
(
((select isnull(IssFactor,0) from ItemUnit where ItemId = i.ItemId)/
(select isnull(PurFactor,0) from ItemUnit where ItemId = i.ItemId))
*
(
(Select isnull(Sum(Qty),0) from WareHouse_Branch where [Type]='In' and ItemId=i.ItemId and SId=@Sid  )
 -
(Select isnull(Sum(Qty),0) from WareHouse_Branch where [Type]='Out' and ItemId=i.ItemId  and SId=@Sid ))),2) AS DECIMAL (18,2))as Balance,

--Cast(isnull(Round((select isnull(avg(Rate),0) from WareHouse_Store where ItemId=i.ItemId  and SId=@Sid)*
--((select isnull(PurFactor,0) from ItemUnit where ItemId=i.ItemId)/
--(select isnull(IssFactor,0) from ItemUnit where ItemId=i.ItemId)),2),0) AS DECIMAL (18,2))
--as Rate




Cast((Round((select isnull(IssFactor,0) from ItemUnit where ItemId = i.ItemId)/
(select isnull(PurFactor,0) from ItemUnit where ItemId = i.ItemId),2)) AS DECIMAL (18,2)) as Factor,
iu.PurUnit as PurUnitId,(select Unit from Unit where UId = iu.PurUnit) as PurUnit

From Item i 
inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.IssUnit=u.Uid 
inner join SubCategory s on i.SBId=s.SBID

where 
ipl.Sid = @SId and ipl.BRId=0 and s.SubCategory like 'Sub%'
group by i.ItemId,i.Item,u.Unit,u.UId,ipl.Parlevel,iu.PurUnit
order by i.Item





