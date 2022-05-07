Create proc [dbo].[UspBindInvoiceNew]
as
select i.InvoiceId,I.InvoiceNo from InvoiceMaster_Company i 

order by I.InvoiceNo




