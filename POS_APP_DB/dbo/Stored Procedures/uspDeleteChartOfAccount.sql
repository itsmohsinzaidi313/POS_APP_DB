CREATE proc [dbo].[uspDeleteChartOfAccount]--151,2
@CAId as int,
@COId as int
as
declare @Count as int;
set @Count = 0;
BEGIN TRY
   BEGIN TRANSACTION   

delete from Vendor 
where CAId = @CAId 

delete from Customer 
where CAId = @CAId 

delete from AccountOpenBalance 
where CAId = @CAId 

COMMIT

delete from ChartOfAccount 
where CAId = @CAId and COId = @COId

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH

Select @Count = CAId from AccountOpenBalance where CAId = @CAId 
Select @Count


