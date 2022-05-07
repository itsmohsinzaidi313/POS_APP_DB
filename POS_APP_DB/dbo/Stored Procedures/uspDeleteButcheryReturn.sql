Create proc [dbo].[uspDeleteButcheryReturn]--5

@BUTRId as int
as
BEGIN TRY
   -- Start A Transaction
   BEGIN TRANSACTION   

delete from ButcheryReturnDetail
where BUTRId=@BUTRId

   COMMIT

delete from ButcheryReturnMaster
where BUTRId=@BUTRId

--delete from WareHouse_Branch
--where IssRTId=@IssRTId

delete from WareHouse_Store
where BUTRId=@BUTRId



select * from ButcheryReturnDetail
where BUTRId=@BUTRId


END TRY
BEGIN CATCH

  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH











