create proc [dbo].[uspInsertAccountPeriod]
(
@From as datetime,
@To as datetime,
@COId as int
)
as

BEGIN TRY
   BEGIN TRANSACTION   

insert into AccountPeriod
([From],
[To],
COId)
values 
(
@From ,
@To ,
@COId 
)

COMMIT

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH

