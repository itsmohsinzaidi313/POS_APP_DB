



CREATE Proc [dbo].[ReportDSNoWiseDemandSheetStore]--'76','Admin','DO-0001'
@COId as int,
@Login as nvarchar(max),
--@DSNo as varchar(50)
@DSNoId as text,
@SId as int
as
select @Login as LoginUser,dm.Date,dm.DSNo,s.Store,c.Category
--,sc.Subcategory
,i.Item,
U.Unit as PackingType,
iu.PurFactor as UnitQty,Un.Unit as IssuanceType,iu.IssFactor,
Uni.Unit as ReceipeType,iu.RecpFactor,UT.Unit as PurchaseUnit,iu.PkFactor,
i.ItemCode as UnitType,
--ipl.ParLevel,
(select ParLevel from ItemParLevel where ItemId= i.ItemId and SId = @SId) as ParLevel,
isnull
(
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='In' and w.ItemId=i.ItemId and w.SId=dm.SId and w.Date<dm.Date)
-
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='Out' and w.ItemId=i.ItemId and w.SId=dm.SId and w.Date<dm.Date)
,0)
+
isnull
(
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='In' and w.ItemId=i.ItemId and w.SId=dm.SId and w.OpenInvid > 0)
,0)
as AvailableQty,
ds.Qty as OrderQty,dm.[Desc] as Subcategory
from DemandSheetMaster_Store dm 
inner join DemandSheetDetail_Store ds on dm.DSCOId=ds.DSCOId
inner join Store s on dm.SId=s.SId
inner join Item i on ds.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
--inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Unit Un on iu.IssUnit=Un.UId
inner join Unit Uni on iu.RecpUnit=Uni.UId
inner join Unit UT on iu.PurUnit=UT.UId
inner join Split(@DSNoId,',') sp on sp.items = dm.DSCOId
where dm.COId=@COId  --and ipl.BRId=0 and ipl.SId>0 
and dm.SId=@SId
group by dm.Date,dm.DSNo,c.Category,dm.[Desc],i.Item,
U.Unit,iu.PurFactor,Un.Unit,iu.IssFactor,Uni.Unit,iu.RecpFactor,UT.Unit,iu.PkFactor,ds.Unit,
--ipl.ParLevel,
i.ItemId,dm.SId,ds.Qty,s.store,i.itemcode
order by dm.date asc
