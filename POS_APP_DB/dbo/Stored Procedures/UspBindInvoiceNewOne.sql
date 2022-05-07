Create proc [dbo].[UspBindInvoiceNewOne]
as
select i.InvoiceId,I.InvoiceNo from InvoiceMaster_Company i 


 Where NOT EXISTS
(
select * from PurchaseReturnMaster where InvoiceId = i.InvoiceId
)

order by I.InvoiceNo





