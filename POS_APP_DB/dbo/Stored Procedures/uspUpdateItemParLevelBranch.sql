Create proc [dbo].[uspUpdateItemParLevelBranch]

@ParLevel decimal(18,2),
@ItemId int,
@BRId int

as

BEGIN TRY
   BEGIN TRANSACTION   

update ItemParLevel set [ParLevel] = @ParLevel
where ItemId = @ItemId and BRId = @BRId

   COMMIT

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back

EXECUTE [uspGetErrorInfo]
END CATCH