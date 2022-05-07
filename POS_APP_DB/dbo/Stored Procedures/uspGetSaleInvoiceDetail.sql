create proc [dbo].[uspGetSaleInvoiceDetail]
@InvoiceId as int
as

--select [Desc] as [Desc],Amount from SaleInvoiceDetail where SaleInvoiceId = @InvoiceId


select ivd.[Desc],ivd.Amount as Amount,
(select AccName from ChartOfAccount where CAId = ivd.CAId) as Account,
(select [Type] from GL where VN = i.SaleInvoiceNo and CAId = ivd.CAId) as [Type],
ivd.CAId,
(select AccNature from ChartOfAccount where CAId = ivd.CAId) as AccNature

from SaleInvoiceMaster i 
inner join SaleInvoiceDetail ivd on i.SaleInvoiceId = ivd.SaleInvoiceId
where i.SaleInvoiceId = @InvoiceId



