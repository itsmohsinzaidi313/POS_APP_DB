CREATE Proc [dbo].[GetGRNDetailDataByInvoice]--'INV-0002'
@InvoiceNo as nvarchar(50)
as
Select i.ItemId,i.Item,u.Unit,u.UId,isd.Qty,isd.Rate as RatePerPcs,
isd.DiscountPerPcs,isd.TaxPerPcs
,isd.TotalPackage
,isd.PcsPerPackage,isd.RatePerPackage,
Round ((isd.Qty*isd.Rate),2) as Amount,
--isd.Amount,
Round ((isd.Qty*isd.DiscountPerPcs),2) as Discount,
Round ((isd.Qty*isd.TaxPerPcs),2) as Tax,
isd.NetAmount,
isd.POId,po.PONo as PONO,
isd.PackageId
,(select Unit from Unit where Uid=isd.PackageId)as Type,
isd.TaxType,tx.Id as TaxMode
from InvoiceMaster_Company ism
inner join InvoiceDetail_Company isd on isd.InvoiceId=ism.InvoiceId
inner join Item i on isd.ItemId=i.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.PurUnit=u.Uid
left join Tax_ tx on tx.Id=isd.TaxMode
inner join PurchaseOrderMaster_Store po on isd.POId=po.POId
inner join GRNMaster gm on ism.GRNId=gm.GRNId
where ism.InvoiceNo=@InvoiceNo
