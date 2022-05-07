CREATE proc [dbo].[uspStockTaking]
@SId as int
as
--Declare @SId as int
--
--set @SId = 115

Select i.ItemId,i.Item,
u.Unit,
u.UId,
ipl.Parlevel,

Cast(Round(
(
(select isnull(IssFactor,0) from ItemUnit where ItemId = i.ItemId)
*
(
(Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='In' and ItemId=i.ItemId and SId=@Sid  )
 -
(Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='Out' and ItemId=i.ItemId  and SId=@Sid ))),2) AS DECIMAL (18,2))as Balance,

Cast(isnull(Round(
(select isnull(avg(Rate),0) from WareHouse_Store where ItemId=i.ItemId  and SId=@Sid)/
(select isnull(IssFactor,0) from ItemUnit where ItemId=i.ItemId),2),0) AS DECIMAL (18,2))as Rate,
Cast((Round(
--(select isnull(IssFactor,0) from ItemUnit where ItemId = i.ItemId)
--/
(select isnull(IssFactor,0) from ItemUnit where ItemId = i.ItemId),2)) AS DECIMAL (18,2)) as Factor,
iu.PurUnit as PurUnitId,(select Unit from Unit where UId = iu.PurUnit) as PurUnit
,isnull(sum(phd.Qty),0) as PhysicalStock,
[dbo].funcCalculateConsumption(
(Cast(Round(
(
(select isnull(IssFactor,0) from ItemUnit where ItemId = i.ItemId)
*
(
(Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='In' and ItemId=i.ItemId and SId=@Sid  )
 -
(Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='Out' and ItemId=i.ItemId  and SId=@Sid ))),2) AS DECIMAL (18,2))
),isnull(sum(phd.Qty),0)
) as Consumption
--Cast(isnull(Round(avg(IssFactor),2),0) AS DECIMAL (18,2))
From Item i 
inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.IssUnit=u.Uid 
inner join PhysicalStockDetail_Store phd on i.ItemId = phd.ItemId
inner join PhysicalStockMaster_Store phm on phm.PSId = phd.PSId
inner join Butchery bu on bu.Id=i.[Type] 
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
where 
ipl.Sid = @SId and ipl.BRId=0 
and phm.PSNO = (select max(PSNO) from PhysicalStockMaster_Store)
--and bu.ItemType='Non Butchery'and sc.SubCategory<>'Sub Recipe'
group by i.ItemId,i.Item,u.Unit,u.UId,ipl.Parlevel,iu.PurUnit
order by i.Item