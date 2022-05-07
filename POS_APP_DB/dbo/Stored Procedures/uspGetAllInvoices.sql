create proc [dbo].[uspGetAllInvoices]
as
select i.InvoiceId,i.VId,v.Vendor,i.Date,i.InvoiceNo,i.RefrenceNo,i.Amount,i.TotalTax,i.Discount,i.TotalAmount 
from InvoiceMaster_CompanyNew i
inner join Vendor v on i.VId = v.VId
order by i.Date desc