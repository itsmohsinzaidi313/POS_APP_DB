



CREATE Proc [dbo].[ReportSubcategoryDateWiseDemandSheetStore]--'76','12-12-2013','12-12-2013','Ammar','28,25'
@COId as int,
@From as datetime,
@To as Datetime,
@Login as nvarchar(max),
@SubCategoryId as text,
@SId as int
as
Declare @ReportName as nvarchar(max);
set @ReportName='Demand Sheet Store SubCategory Wise';
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],@Login as LoginUser,dm.Date,dm.DSNo,@ReportName as Store,c.Category as Subcategory,sc.Subcategory as Category,i.Item,
U.Unit as PackingType,
iu.PurFactor as UnitQty,Un.Unit as IssuanceType,iu.IssFactor,
Uni.Unit as ReceipeType,iu.RecpFactor,UT.Unit as PurchaseUnit,iu.PkFactor,
(Select Distinct(Unit) from unit  where UId=ds.Unit) as UnitType,
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
ds.Qty as OrderQty from DemandSheetMaster_Store dm 
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
inner join Split(@SubCategoryId,',') sp on sp.items = sc.SBId
where dm.Date between @From and @To and dm.COId=@COId  --and ipl.BRId=0 and ipl.SId>0
and dm.SId=@SId
group by dm.Date,dm.DSNo,c.Category,sc.Subcategory,i.Item,
U.Unit,iu.PurFactor,Un.Unit,iu.IssFactor,Uni.Unit,iu.RecpFactor,UT.Unit,iu.PkFactor,ds.Unit,
--ipl.ParLevel,
i.ItemId,dm.SId,ds.Qty
order by dm.date asc
















