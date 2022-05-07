create function [dbo].[funcTrialBalanceCredit]
(
@Amount decimal(18,2),
@AccNature nvarchar(50)
)
returns decimal(18,2)
as
Begin

Declare @Final decimal(18,2);
set @Final =0;

if @AccNature = 'LIABILITIES' or @AccNature = 'OWNER EQUITY' or @AccNature = 'REVENUE'
Begin
set @Final = @Amount
End

return @Final 
End
