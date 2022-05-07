

CREATE Proc [dbo].[ReportSubcategoryDateWiseDemandSheetBranch]
@From as datetime,
@To as Datetime,
@Login as nvarchar(max),
@SubCategoryId as text
as
Declare @ReportName as nvarchar(max);
set @ReportName='Demand Sheet Branch SubCategory Wise';
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],@Login as LoginUser,dm.Date,dm.DSNo,@ReportName as Branch,d.department_name as Category,sc.Subcategory,i.Item,
--U.Unit as PackingType,
s.Branch as PackingType,
iu.PurFactor as UnitQty,Un.Unit as IssuanceType,iu.IssFactor,
Uni.Unit as ReceipeType,iu.RecpFactor,UT.Unit as PurchaseUnit,iu.PkFactor,
--(Select Distinct(Unit) from unit  where UId=ds.Unit) as UnitType,
--s.Branch 
--+ ' - ' +d.department_name 
--as UnitType,
sc.Subcategory as UnitType,
ipl.ParLevel,
isnull
(
(Select isnull(sum(Qty),0) from WareHouse_Branch w where [Type]='In' and w.ItemId=i.ItemId and w.BRId=dm.BRId and w.Date<dm.Date and w.DId = d.id)
-
(Select isnull(sum(Qty),0) from WareHouse_Branch w where [Type]='Out' and w.ItemId=i.ItemId and w.BRId=dm.BRId and w.Date<dm.Date and w.DId = d.id)
,0)
as AvailableQty,
ds.Qty as OrderQty from DemandSheetMaster_Branch dm 
inner join DemandSheetDetail_Branch ds on dm.DSId=ds.DSId
inner join Branch s on dm.BRId=s.BRId
inner join DepartmentPos d on s.BRId=d.BRId
inner join Item i on ds.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join ItemParLevel ipl on i.ItemId=ipl.ItemId and ipl.DId = d.id
inner join Unit U on iu.PkUnit=U.UId
inner join Unit Un on iu.IssUnit=Un.UId
inner join Unit Uni on iu.RecpUnit=Uni.UId
inner join Unit UT on iu.PurUnit=UT.UId
inner join Split(@SubCategoryId,',') sp on sp.items = sc.SBId
where dm.Date between @From and @To and ipl.BRId>0 and ipl.SId=0 and dm.DId = d.id
group by dm.Date,dm.DSNo,c.Category,sc.Subcategory,i.Item,U.Unit,
iu.PurFactor,Un.Unit ,iu.IssFactor,Uni.Unit,iu.RecpFactor,UT.Unit,iu.PkFactor
,ds.Unit,ipl.ParLevel,i.ItemId,dm.BRId,ds.Qty,s.Branch,d.department_name,d.id
order by dm.date asc














