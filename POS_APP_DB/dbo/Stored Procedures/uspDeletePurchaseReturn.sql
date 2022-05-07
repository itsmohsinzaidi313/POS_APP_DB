CREATE proc [dbo].[uspDeletePurchaseReturn]--111

@PRId as int
as
BEGIN TRY
   -- Start A Transaction
   BEGIN TRANSACTION   

delete from PurchaseReturnDetailNew
where PRId=@PRId

   COMMIT

delete from PurchaseReturnMasterNew
where PRId=@PRId

--delete from SupplierLedger
--where VoucherId=@PRId 

delete from WareHouse_Store
where PRId=@PRId

select * from PurchaseReturnMasterNew
where PRId=@PRId


END TRY
BEGIN CATCH

  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH












