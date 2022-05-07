create proc [dbo].[uspUpdateAccountPeriod]
(
@ApId as int,
@COId as int
)
as

BEGIN TRY
   BEGIN TRANSACTION   

update AccountPeriod set IsActive = 0 where ApId = @ApId and COId = @COId

COMMIT

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH

