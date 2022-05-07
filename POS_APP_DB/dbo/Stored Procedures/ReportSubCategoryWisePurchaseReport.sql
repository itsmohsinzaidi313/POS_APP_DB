


CREATE Proc [dbo].[ReportSubCategoryWisePurchaseReport]--'6/26/2013 12:00:00 AM','6/26/2013 12:00:00 AM','Admin','28'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max),
@SubCategoryId as text
as
Declare @ReportName as nvarchar(max);
set @ReportName='Goods Purchasing SubCategory wise';
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],@Login as LoginUser,im.Date,gm.GRNo,v.Vendor,@ReportName as store,c.Category as Subcategory,sc.Subcategory as Category,i.Item,
--U.Unit as PackingType
idc.TotalPackage,idc.PcsPerPackage as UnitQty,

(Select Unit from unit  where UId=idc.PackageId) as PackingType,
--dsm.DSNo,
im.InvoiceNo,
--iu.PkFactor as UnitQty,
 im.Discount,ps.PONo,
Un.Unit as IssuanceType,iu.IssFactor,iu.PurFactor,
Uni.Unit as ReceipeType,iu.RecpFactor,UT.Unit as PurchaseUnit,iu.PkFactor,
(Select Distinct(Unit) from unit  where UId=idc.Unit) as UnitType,
isnull
(
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='In' and w.ItemId=i.ItemId and w.SId=im.SId and w.Date < im.Date)
-
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='Out' and w.ItemId=i.ItemId and w.SId=im.SId and w.Date < im.Date)
,0)as AvailableQty,
--ipl.ParLevel,
(select ParLevel from ItemParLevel where ItemId= i.ItemId and SId = im.SId) as ParLevel,
idc.Rate as UnitPrice,
idc.Qty as PurchaseQty from InvoiceMaster_CompanyNew im
inner join InvoiceDetail_CompanyNew idc on im.InvoiceId=idc.InvoiceId
inner join GRNMaster gm on gm.GRNId=idc.GRNId
left join PurchaseOrderMaster_Store ps on ps.POId=idc.POId
--inner join PurchaseOrderDetail_Store psd on ps.POId=psd.POId
--inner join DemandSheetMaster_Store dsm on dsm.DSCOId=psd.DSCOId
inner join Vendor v on v.VId=im.VId
inner join Store s on im.SId=s.SId
inner join Item i on idc.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
--inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Unit Un on iu.IssUnit=Un.UId
inner join Unit Uni on iu.RecpUnit=Uni.UId
inner join Unit UT on iu.PurUnit=UT.UId
inner join Split(@SubCategoryId,',') sp on sp.items = sc.SBId
where im.Date between @From and @To  --and ipl.BRId=0
group by im.Date, im.InvoiceNo,gm.GRNo,v.Vendor,c.Category,sc.Subcategory,i.Item,idc.TotalPackage,
idc.PcsPerPackage,idc.PackageId,U.Unit,
--dsm.DSNo,
im.Discount,ps.PONo,Un.Unit,iu.IssFactor,iu.PurFactor,Uni.Unit,
iu.RecpFactor,UT.Unit,iu.PkFactor,im.SId ,i.ItemId,
idc.Unit,
--ipl.ParLevel,
idc.Rate,idc.Qty
order by im.date asc
















