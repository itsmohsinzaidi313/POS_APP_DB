
CREATE proc [dbo].[uspDeleteInvoice]--111

@InvoiceId as int
as
BEGIN TRY
   -- Start A Transaction
   BEGIN TRANSACTION   

delete from InvoiceDetail_CompanyNew
where InvoiceId=@InvoiceId

   COMMIT
delete from SupplierLedger
where VoucherId=@InvoiceId 
--delete from WareHouse_Store where  InvoiceId=@InvoiceId
delete from gl
where VoucherId=@InvoiceId and VoucherType = 'PURCHASE'

delete from InvoiceMaster_CompanyNew
where InvoiceId=@InvoiceId

select * from InvoiceMaster_CompanyNew
where InvoiceId=@InvoiceId

END TRY
BEGIN CATCH

  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH