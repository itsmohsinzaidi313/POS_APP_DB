Create proc [dbo].[uspDeleteISSButchery]--111

@BUTId as int
as
BEGIN TRY
   -- Start A Transaction
   BEGIN TRANSACTION   

delete from IssuanceButcheryDetail
where BUTId=@BUTId

   COMMIT

delete from IssuanceButcheryMaster
where BUTId=@BUTId

delete from WareHouse_Store
where BUTId=@BUTId

select * from IssuanceButcheryMaster
where BUTId=@BUTId


END TRY
BEGIN CATCH

  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH










