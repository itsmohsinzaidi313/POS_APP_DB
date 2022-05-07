CREATE Function [dbo].[GetInvoiceNoForSupplyledgerReport]
(
@InvoiceId as int,
@VoucherType as nvarchar(50)
)
returns nvarchar(50)
as
begin
declare @InvoiceNo nvarchar(50);
if @VoucherType = 'Purchase'
begin
select @InvoiceNo = InvoiceNo from InvoiceMaster_Company where InvoiceId=@InvoiceId
end
else
begin
select @InvoiceNo = InvoiceNo from InvoiceMaster_Company where InvoiceId=@InvoiceId
end
--return @InvoiceNo
--end

if @VoucherType = 'PurchaseRe'
begin
select @InvoiceNo = PRNo from PurchaseReturnMaster where PRId=@InvoiceId
end
else
begin
select @InvoiceNo = PRNo from PurchaseReturnMaster where PRId=@InvoiceId
end


return @InvoiceNo
end

