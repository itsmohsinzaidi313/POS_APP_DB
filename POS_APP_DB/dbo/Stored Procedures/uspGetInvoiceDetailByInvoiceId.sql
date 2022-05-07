CREATE proc [dbo].[uspGetInvoiceDetailByInvoiceId]
@InvoiceId as int
as
select gm.GRNo,gm.Date,po.PONo,i.Item,u.Unit,(select Unit from Unit where UId = id.PackageId) as Package,
id.TotalPackage,id.PcsPerPackage,id.RatePerPackage,id.Qty,id.ActualRate as Rate,Cast((id.Qty * id.ActualRate) as decimal(18,2)) as Amount,
id.Tax as TotalTax,id.Discount,id.Amount as TotalAmount,id.TaxType
from InvoiceDetail_CompanyNew id
inner join GRNMaster gm on id.GRNId = gm.GRNId
left join PurchaseOrderMaster_Store po on id.POId = po.POId
inner join Item i on id.ItemId = i.ItemId
inner join Unit u on id.Unit = u.UId
where id.InvoiceId = @InvoiceId