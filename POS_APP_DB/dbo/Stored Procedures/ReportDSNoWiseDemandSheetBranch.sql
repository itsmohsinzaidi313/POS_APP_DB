

CREATE Proc [dbo].[ReportDSNoWiseDemandSheetBranch]--'Admin','65,'
@Login as nvarchar(max),
--@DSNo as varchar(50)
@DSNoId as text
as
select @Login as LoginUser,dm.Date,dm.DSNo,s.Branch,
--c.Category,
--sc.Subcategory,
d.department_name as Subcategory,
i.Item,
U.Unit as PackingType,
iu.PurFactor as UnitQty,Un.Unit as IssuanceType,iu.IssFactor,
Uni.Unit as ReceipeType,iu.RecpFactor,UT.Unit as PurchaseUnit,iu.PkFactor,
i.ItemCode as UnitType,
ipl.ParLevel,
isnull
(
(Select isnull(sum(Qty),0) from WareHouse_Branch w where [Type]='In' and w.ItemId=i.ItemId and w.BRId=dm.BRId and w.Date=dm.Date)
-
(Select isnull(sum(Qty),0) from WareHouse_Branch w where [Type]='Out' and w.ItemId=i.ItemId and w.BRId=dm.BRId and w.Date=dm.Date)
,0)
as AvailableQty,
ds.Qty as OrderQty,dm.[Desc] as Category from DemandSheetMaster_Branch dm 
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
inner join Split(@DSNoId,',') sp on sp.items = dm.DSId
where ipl.BRId>0 and ipl.SId=0 and dm.DId = d.id
group by dm.Date,dm.DSNo
--,c.Category
,sc.Subcategory,i.Item,U.Unit,
iu.PurFactor,Un.Unit ,iu.IssFactor,Uni.Unit,iu.RecpFactor,UT.Unit,iu.PkFactor
,ds.Unit,ipl.ParLevel,i.ItemId,dm.BRId,ds.Qty,s.Branch,i.ItemCode,d.department_name,d.id,dm.[Desc]
order by dm.DSNo asc

















