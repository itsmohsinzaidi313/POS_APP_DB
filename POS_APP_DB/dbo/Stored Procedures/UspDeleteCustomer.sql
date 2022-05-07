create proc [dbo].[UspDeleteCustomer]

@VId as int

as
--select * from Customer
--where
--CustId =@VId


BEGIN TRY
   BEGIN TRANSACTION   

Declare @Return int
set @Return =0;
Declare @CAId int

select @CAId = CAId from Customer where CustId = @VId

Declare @AccOpBal int;
set @AccOpBal = 0;
select @AccOpBal = count(CAId) from AccountOpenBalance where CAId = @CAId and Amount > 0

Declare @GL int;
set @GL = 0;
--select @GL = count(CAId) from gl where CAId = @CAId 
select @GL = count(CustId) from CustomerLedger where CustId = @VId 

if @GL = 0 
--and @AccOpBal = 0
Begin
delete from Customer
where
CustId=@VId 

set @Return = 1;

--and CAId = @CAId

--delete from dbo.AccountOpenBalance where CAId = @CAId
End
COMMIT

--delete from dbo.ChartOfAccount where CAId = @CAId
--set @CAId = 0;
--select @CAId = CAId from Customer where CustId = @VId

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH
select @Return

