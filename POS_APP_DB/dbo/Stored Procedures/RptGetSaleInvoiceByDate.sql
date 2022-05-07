CREATE Proc [dbo].[RptGetSaleInvoiceByDate] --'2016-05-10 00:00:00.000','2016-11-10 00:00:00.000'
@DateFrom as Datetime,
@DateTo as Datetime
as
select '' as DateFrom,i.SaleInvoiceNo,v.Customer ,
--p.Project ,
ca.accname as Project,
i.Date,i.Amount,i.Discount,i.TotalAmount,d.[Desc] as Description,d.Amount as DetailAmount 
from SaleInvoiceMaster i inner join SaleInvoiceDetail d on i.SaleInvoiceId=d.SaleInvoiceId inner join Customer v on i.CustId=v.CustId
inner join chartofaccount ca on ca.caid = d.caid
--inner join Project p on i.ProId = p.id
where 
i.Date between @DateFrom and @DateTo and
d.CAId <> (select CAId from Customer where CustId = i.CustId)