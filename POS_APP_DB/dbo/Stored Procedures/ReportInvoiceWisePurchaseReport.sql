

CREATE Proc [dbo].[ReportInvoiceWisePurchaseReport]--17,'Admin'
@PINOId as nvarchar(50),
@Login as nvarchar(max)
as
--select
--im.Date,
--v.Vendor,
--idc.TaxType as Subcategory,
--i.Item,
--idc.TotalPackage,idc.PcsPerPackage as UnitQty,
--idc.DiscountPerPcs as IssuanceType,idc.TaxPerPcs as Parlevel, tx.TaxType as LoginUser,
--(Select Unit from unit  where UId=idc.PackageId) as PackingType,
--im.InvoiceNo,
-- im.Discount
--,v.Address,v.CellNo
--,im.TotalAmount as IssFactor,
--iu.PurFactor,
--Uni.Unit as ReceipeType,im.Amount as RecpFactor,UT.Unit as PurchaseUnit,
--im.TotalTax
--as PkFactor,
--i.ItemCode as UnitType,
--ipl.ParLevel,idc.Rate as UnitPrice,
--idc.Qty as PurchaseQty from InvoiceMaster_Company im
--inner join InvoiceDetail_Company idc on im.InvoiceId=idc.InvoiceId
--inner join GRNMaster gm on gm.GRNId=im.GRNId
--inner join PurchaseOrderMaster_Store ps on ps.POId=idc.POId
--inner join PurchaseOrderDetail_Store psd on ps.POId=psd.POId
--inner join DemandSheetMaster_Store dsm on dsm.DSCOId=psd.DSCOId
--inner join Vendor v on v.VId=im.VId
--inner join Store s on im.SId=s.SId
--inner join Item i on idc.ItemId=i.ItemId
--inner join Subcategory sc on i.SBId = sc.SBId
--inner join Category c on sc.CId=c.CId
--inner join ItemUnit iu on i.ItemId=iu.ItemId
--inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
--inner join Unit U on iu.PkUnit=U.UId
--inner join Unit Un on iu.IssUnit=Un.UId
--inner join Unit Uni on iu.RecpUnit=Uni.UId
--inner join Unit UT on iu.PurUnit=UT.UId
--inner join Tax_ tx on idc.TaxMode=tx.Id
--inner join Split(@PINOId,',') sp on sp.items =im.InvoiceId
--where ipl.BRId=0
--group by im.Date, im.InvoiceNo,
--v.Vendor,c.Category,sc.Subcategory,i.Item,idc.TotalPackage,
--idc.PcsPerPackage,idc.PackageId,U.Unit,
--im.Discount,
--Un.Unit,im.TotalAmount ,iu.PurFactor,Uni.Unit,
--im.Amount,i.ItemCode,UT.Unit,im.TotalTax,v.Address,v.CellNo,
--idc.Unit,ipl.ParLevel,idc.Rate,idc.Qty,idc.DiscountPerPcs,idc.TaxPerPcs,tx.TaxType,idc.TaxType
--order by im.date asc


select
-- @Login as LoginUser,
im.Date,gm.GRNo,v.Vendor,
--c.Category,
idc.TaxType as Subcategory,
i.Item,
--U.Unit as PackingType
--idc.TotalPackage,
idc.Discount as TotalPackage,
idc.PcsPerPackage as UnitQty,
idc.Discount as IssuanceType,
--idc.TaxPerPcs as Parlevel, 
idc.TaxType as LoginUser,
(Select Unit from unit  where UId=idc.PackageId) as PackingType,
--dsm.DSNo,
im.InvoiceNo,
--iu.PkFactor as UnitQty,
 im.Discount,ps.PONo,v.Address,v.CellNo
--Un.Unit as IssuanceType
,im.TotalAmount as IssFactor,
iu.PurFactor,
Uni.Unit as ReceipeType,im.Amount as RecpFactor,UT.Unit as PurchaseUnit,
im.TotalTax
as PkFactor,
i.ItemCode as UnitType,
--ipl.ParLevel,
idc.Tax as ParLevel,
--idc.Rate as UnitPrice,
idc.ActualRate as UnitPrice,

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
--left join Tax_ tx on idc.TaxMode=tx.Id
inner join Split(@PINOId,',') sp on sp.items =im.InvoiceId
--where ipl.BRId=0
group by im.Date, im.InvoiceNo,gm.GRNo,v.Vendor,c.Category,sc.Subcategory,i.Item,idc.TotalPackage,
idc.PcsPerPackage,idc.PackageId,U.Unit,
--dsm.DSNo,
im.Discount,ps.PONo,Un.Unit,im.TotalAmount ,iu.PurFactor,Uni.Unit,
im.Amount,i.ItemCode,UT.Unit,im.TotalTax,v.Address,v.CellNo,
idc.Unit,
--ipl.ParLevel,
idc.ActualRate,idc.Qty,idc.Tax,idc.Discount,
--idc.DiscountPerPcs,
--idc.TaxPerPcs,
idc.TaxType
order by im.date asc
