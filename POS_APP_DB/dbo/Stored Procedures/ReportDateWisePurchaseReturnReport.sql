
CREATE Proc [dbo].[ReportDateWisePurchaseReturnReport]--'6/26/2013 12:00:00 AM','7/31/2013 12:00:00 AM','Admin','30'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max)
as
Declare @ReportName as nvarchar(max);
set @ReportName='Purchase Return Date wise';
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],
@Login as LoginUser,prm.Date,gm.GRNo,v.Vendor,@ReportName as store,c.Category,sc.Subcategory,i.Item,
prd.TotalPackage,prd.PcsPerPackage as UnitQty,

(Select Unit from unit  where UId=prd.PackageId) as PackingType,
dsm.DSNo,

prm.PRNo,ic.InvoiceNo,idc.Qty as PurchaseQty,
 prm.Discount,ps.PONo,
Un.Unit as IssuanceType,iu.IssFactor,iu.PurFactor,
Uni.Unit as ReceipeType,iu.RecpFactor,UT.Unit as PurchaseUnit,iu.PkFactor,
(Select Distinct(Unit) from unit  where UId=prd.Unit) as UnitType,
isnull
(
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='In' and w.ItemId=i.ItemId and w.SId=prm.SId and w.Date < prm.Date)
-
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='Out' and w.ItemId=i.ItemId and w.SId=prm.SId and w.Date < prm.Date)
,0)as AvailableQty,
ipl.ParLevel,prd.Rate as UnitPrice,
prd.Qty as ReturnQty from PurchaseReturnMaster prm
inner join PurchaseReturnDetail prd on prm.PRId=prd.PRId
inner join InvoiceMaster_Company ic on ic.InvoiceId=prm.InvoiceId
inner join InvoiceDetail_Company idc on ic.InvoiceId=idc.InvoiceId
inner join GRNMaster gm on gm.GRNId=prd.GRNId
inner join PurchaseOrderMaster_Store ps on ps.POId=prd.POId
inner join PurchaseOrderDetail_Store psd on ps.POId=psd.POId
inner join DemandSheetMaster_Store dsm on dsm.DSCOId=prd.DSCOId
inner join Vendor v on v.VId=prm.VId
inner join Store s on prm.SId=s.SId
inner join Item i on prd.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Unit Un on iu.IssUnit=Un.UId
inner join Unit Uni on iu.RecpUnit=Uni.UId
inner join Unit UT on iu.PurUnit=UT.UId
where prm.Date between @From and @To  and ipl.BRId=0
group by prm.Date,prm.PRNo, ic.InvoiceNo,gm.GRNo,v.Vendor,c.Category,sc.Subcategory,i.Item,prd.TotalPackage,
prd.PcsPerPackage,prd.PackageId,U.Unit,
dsm.DSNo,
ic.InvoiceNo,idc.Qty,
prm.Discount,ps.PONo,Un.Unit,iu.IssFactor,iu.PurFactor,Uni.Unit,
iu.RecpFactor,UT.Unit,iu.PkFactor,prm.SId ,i.ItemId,
prd.Unit,ipl.ParLevel,prd.Rate,prd.Qty
order by prm.date asc














