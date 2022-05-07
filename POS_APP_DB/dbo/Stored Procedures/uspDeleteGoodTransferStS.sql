Create proc [dbo].[uspDeleteGoodTransferStS]--111

@TransferId as int,
@TRIId as int,
@TRId as int
as
BEGIN TRY
   -- Start A Transaction
   BEGIN TRANSACTION   

delete from WareHouse_Store
where TRInId=@TRIId

delete from WareHouse_Store
where TROutId =@TRId

   COMMIT

delete from TransferInDetail
where TRIId=@TRIId

delete from TransferOutMaster
where TRId=@TRId 

delete from TransferInMaster
where TRIId=@TRIId

delete from Transfer
where TransferId=@TransferId

--select * from PurchaseReturnMaster
--where PRId=@PRId


END TRY
BEGIN CATCH

  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH












