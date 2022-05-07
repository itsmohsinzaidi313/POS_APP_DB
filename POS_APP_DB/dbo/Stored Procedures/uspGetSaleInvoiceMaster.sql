create proc [dbo].[uspGetSaleInvoiceMaster]
@InvoiceId as int
as
select * from SaleInvoiceMaster where SaleInvoiceId = @InvoiceId


