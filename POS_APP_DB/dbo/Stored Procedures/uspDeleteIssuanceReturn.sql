CREATE proc [dbo].[uspDeleteIssuanceReturn]--5

@IssRTId as int
as
BEGIN TRY
   -- Start A Transaction
   BEGIN TRANSACTION   

delete from IssuanceReaturnDetail
where IssRTId=@IssRTId

   COMMIT

delete from IssuanceReturnMaster
where IssRTId=@IssRTId

delete from WareHouse_Branch
where IssRTId=@IssRTId

delete from WareHouse_Store
where IssRTId=@IssRTId



select * from IssuanceReaturnDetail
where IssRTId=@IssRTId


END TRY
BEGIN CATCH

  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH










