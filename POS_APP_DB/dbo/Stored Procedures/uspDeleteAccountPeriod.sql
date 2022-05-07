create proc [dbo].[uspDeleteAccountPeriod]
(
@ApId as int,
@COId as int
)
as

BEGIN TRY
   BEGIN TRANSACTION   

delete from AccountPeriod where ApId = @ApId and COId = @COId

COMMIT

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH

