CREATE Proc [dbo].[GetDetailByInvoice]--'INV-0001'
@InvoiceNo as nvarchar(50)
as
Select i.ItemId,i.Item,u.Unit,u.UId,isd.Qty,isd.Rate as RatePerPcs,isd.TotalPackage
,isd.PcsPerPackage,isd.RatePerPackage,
isd.DiscountPerPcs,
isd.TaxPerPcs,
t.Id,
Cast( Round((isd.Qty*isd.Rate),2) AS DECIMAL (18,2))as Amount
,isd.POId,
isd.PackageId
,ism.GRNId,
v.VId
,(select Unit from Unit where Uid=isd.PackageId)as Type
from InvoiceMaster_Company ism
inner join InvoiceDetail_Company isd on isd.InvoiceId=ism.InvoiceId
inner join Item i on isd.ItemId=i.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.PurUnit=u.Uid
left Outer join Tax_ t on t.Id=isd.TaxMode
--inner join PurchaseOrderMaster_Store po on isd.POId=po.POId
--inner join PurchaseOrderDetail_Store psd on po.POId=psd.POId
--inner join DemandSheetMaster_Store dsm on dsm.DSCOId=psd.DSCOId
--inner join GRNMaster gm on ism.GRNId=gm.GRNId
inner join Vendor v on ism.VId=v.VId
where ism.InvoiceNo=@InvoiceNo
group by i.ItemId,i.Item,u.Unit,u.UId,isd.Qty,isd.Rate,
isd.TotalPackage
,isd.PcsPerPackage,isd.RatePerPackage,
isd.POId
,isd.PackageId
,ism.GRNId,v.VId,isd.DiscountPerPcs,
isd.TaxPerPcs,
t.Id
