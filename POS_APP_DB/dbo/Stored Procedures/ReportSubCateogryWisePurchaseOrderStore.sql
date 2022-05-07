


CREATE Proc [dbo].[ReportSubCateogryWisePurchaseOrderStore]--'76','6/26/2013 12:00:00 AM','6/26/2013 12:00:00 AM','Admin','10'
@COId as int,
@From as datetime,
@To as Datetime,
@Login as nvarchar(max),
@SubCategoryId as text,
@SId as int
as
Declare @ReportName as nvarchar(max);
set @ReportName='Purchase Order Store SubCategory wise';
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],@Login as LoginUser,pm.Date,pm.PONo,v.Vendor,@ReportName as store,c.Category as Subcategory,sc.Subcategory as Category,
i.ItemCode + ' - ' + i.Item as Item,
U.Unit as PackingType,
iu.PurFactor as UnitQty,Un.Unit as IssuanceType,iu.IssFactor,
Uni.Unit as ReceipeType,iu.RecpFactor,UT.Unit as PurchaseUnit,iu.PkFactor, ds.DSNo,
(Select Distinct(Unit) from unit  where UId=ps.UId) as UnitType,
--ipl.ParLevel,
(select ParLevel from ItemParLevel where ItemId= i.ItemId and SId = @SId) as ParLevel,
ps.Rate as UnitPrice,
ps.Qty as OrderQty from PurchaseOrderMaster_Store pm 
inner join PurchaseOrderDetail_Store ps on pm.POId=ps.POId
inner join Vendor v on pm.VId=v.VId
left join DemandSheetMaster_Store ds on ps.DSCOId=ds.DSCOId
inner join Store s on pm.SId=s.SId
inner join Item i on ps.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
--inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Unit Un on iu.IssUnit=Un.UId
inner join Unit Uni on iu.RecpUnit=Uni.UId
inner join Unit UT on iu.PurUnit=UT.UId
inner join Split(@SubCategoryId,',') sp on sp.items = sc.SBId
where pm.Date between @From and @To and pm.COId=@COId
and pm.SId=@SId
--and ipl.BRId=0 and ipl.SId>0
group by pm.Date,pm.PONo,v.Vendor,c.Category,sc.Subcategory,i.Item,iu.PurFactor
,Un.Unit,iu.IssFactor,Uni.Unit,iu.RecpFactor,UT.Unit,iu.PkFactor, ds.DSNo,ps.UId,
--ipl.ParLevel,
ps.Rate,ps.Qty,iu.IssFactor,U.Unit,i.ItemId,i.ItemCode
order by pm.date asc

















