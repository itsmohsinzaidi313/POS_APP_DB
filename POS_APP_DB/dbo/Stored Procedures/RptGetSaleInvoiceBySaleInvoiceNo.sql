CREATE Proc [dbo].[RptGetSaleInvoiceBySaleInvoiceNo]
@SaleInvoiceNo as nvarchar(50)
as
select '' as DateFrom,i.SaleInvoiceNo,v.Customer ,
--p.Project ,
ca.accname as Project,
i.Date,i.Amount,i.Discount,i.TotalAmount,d.[Desc] as Description,d.Amount as DetailAmount 
from SaleInvoiceMaster i inner join SaleInvoiceDetail d on i.SaleInvoiceId=d.SaleInvoiceId inner join Customer v on i.CustId=v.CustId
inner join chartofaccount ca on ca.caid = d.caid

--inner join Project p on i.ProId = p.id
where i.SaleInvoiceNo = @SaleInvoiceNo
and d.CAId <> (select CAId from Customer where CustId = i.CustId)