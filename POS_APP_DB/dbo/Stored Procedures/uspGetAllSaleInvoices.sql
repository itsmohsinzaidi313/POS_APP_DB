create proc [dbo].[uspGetAllSaleInvoices]
as
select i.SaleInvoiceId,i.SaleInvoiceNo, i.Date,sp.Customer,i.CustId,i.UserId
from SaleInvoiceMaster i
inner join Customer sp on i.CustId = sp.CustId

