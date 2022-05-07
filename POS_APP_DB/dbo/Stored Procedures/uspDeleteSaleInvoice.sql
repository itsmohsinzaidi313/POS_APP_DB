create proc [dbo].[uspDeleteSaleInvoice]

@InvoiceId int,
@DeleteType as nvarchar(50)

as

BEGIN TRY
   BEGIN TRANSACTION   

if @DeleteType = 'Delete'
begin
delete from SaleInvoiceMaster where SaleInvoiceId = @InvoiceId
end
delete from SaleInvoiceDetail where SaleInvoiceId = @InvoiceId
delete from CustomerLedger where VoucherId = @InvoiceId and VoucherType = 'SALE VOUCHER'
delete from GL where VoucherId = @InvoiceId and VoucherType = 'SALE VOUCHER'
--delete from ProjectLedger where VoucherId = @InvoiceId and VoucherType = 'SALE VOUCHER'


   COMMIT


END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH







