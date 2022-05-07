

CREATE Function [dbo].[GetInvoiceNoForCustomerledgerReport]
(
@InvoiceId as int,
@VoucherType as nvarchar(50)
)
returns nvarchar(50)
as
begin
declare @InvoiceNo nvarchar(50);
if @VoucherType = 'SALE INVOICE'
begin
select @InvoiceNo = SaleInvoiceNo from SaleInvoiceMaster where SaleInvoiceId=@InvoiceId
end
else
begin
select @InvoiceNo = SaleInvoiceNo from SaleInvoiceMaster where SaleInvoiceId=@InvoiceId
end
return @InvoiceNo
end

