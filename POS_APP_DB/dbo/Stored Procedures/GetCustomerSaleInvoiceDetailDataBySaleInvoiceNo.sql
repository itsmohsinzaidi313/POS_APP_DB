
create Proc [dbo].[GetCustomerSaleInvoiceDetailDataBySaleInvoiceNo]--'GRN-0001'
@SaleInvoiceNo as nvarchar(50)
as
Select i.ItemId,i.Item,u.Unit,u.UId,dsd.Qty,dsd.ActualRate as RatePerPcs,dsd.TotalPackage
,dsd.PcsPerPackage,dsd.RatePerPackage,
Cast( Round((dsd.Qty*dsd.Rate),2) AS DECIMAL (18,2))as Amount,
--dsd.POId,po.PONo as PONo,
dsd.PackageId
,(select Unit from Unit where Uid=dsd.PackageId)as [Type],
dsd.Tax,dsd.Discount,dsd.Rate as NetRatePerPcs,dsd.TaxType
--,isnull((select Status from PurchaseOrderDetail_Store where ItemId = i.ItemId and POId = dsd.POId),'False') as Status

from CustomerSaleInvoiceMaster dsm
inner join CustomerSaleInvoiceDetail dsd on dsm.SLId=dsd.SLId
inner join Item i on dsd.ItemId=i.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.PurUnit=u.Uid
--left join PurchaseOrderMaster_Store po on dsd.POId=po.POId
where dsm.SaleInvoiceNo=@SaleInvoiceNo



