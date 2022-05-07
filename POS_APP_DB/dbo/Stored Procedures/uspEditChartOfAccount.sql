create proc [dbo].[uspEditChartOfAccount]

@CAId as int,
@AccName as nvarchar(50),
@COId as int,
@OpenBalance as decimal(18,2),
@AccNo as nvarchar(50)
as

BEGIN TRY
   BEGIN TRANSACTION 

Declare @Return int;
set @Return = 0;
Declare @Count int;
set @Count = 0;
  
--select @Count = isnull(count(CAID),0) from ChartOfAccount 
--where AccName = @AccName and COId = @COId

--if @Count = 0
--Begin
update ChartOfAccount set AccName = @AccName,AccNo = @AccNo where CAId = @CAId and COId = @COId
set @Return = 1;
--End

COMMIT

--if @Count = 0
--Begin

Declare @APId int;
select @APId = max(APId) from AccountPeriod where IsActive = 1

Declare @Type nvarchar(50);
select @Type = [Type] from ChartOfAccount where CAId = @CAId

if @Type = 'DETAIL'
Begin

Update AccountOpenBalance set Amount = @OpenBalance where CAId = @CAId and APId = @APId
set @Return = 1;

End
--End

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
exec [uspGetErrorInfo]
END CATCH
select @Return;



