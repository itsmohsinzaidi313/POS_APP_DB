
CREATE Proc [dbo].[GetMainStoreInventoryBalanceForButchery]--85
@Sid as int
as
Select i.ItemId,i.Item,
u.Unit,
u.UId,
ipl.Parlevel,

Cast(Round(
(
(select isnull(IssFactor,0) from ItemUnit where ItemId = i.ItemId)
*
(
(Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='In' and ItemId=i.ItemId and SId=@Sid and BUTRId=0 and IssId=0 and IssRTId=0)
 -
(Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='Out' and ItemId=i.ItemId  and SId=@Sid  and IssId=0))),2) AS DECIMAL (18,2))as Balance,

Cast(isnull(Round(
(select isnull(avg(Rate),0) from WareHouse_Store where ItemId=i.ItemId  and SId=@Sid)/
(select isnull(IssFactor,0) from ItemUnit where ItemId=i.ItemId),2),0) AS DECIMAL (18,2))as Rate,
Cast((Round((select isnull(IssFactor,0) from ItemUnit where ItemId = i.ItemId)/
(select isnull(PurFactor,0) from ItemUnit where ItemId = i.ItemId),2)) AS DECIMAL (18,2)) as Factor,
iu.PurUnit as PurUnitId,(select Unit from Unit where UId = iu.PurUnit) as PurUnit
--Cast(isnull(Round(avg(IssFactor),2),0) AS DECIMAL (18,2))
From Item i 
inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.IssUnit=u.Uid 
inner join Butchery bu on bu.ItemType=i.[Type] 
where 
ipl.Sid = @SId and ipl.BRId=0 and bu.ItemType='Butchery'
group by i.ItemId,i.Item,bu.ItemType ,u.Unit,u.UId,ipl.Parlevel,iu.PurUnit
order by i.Item














