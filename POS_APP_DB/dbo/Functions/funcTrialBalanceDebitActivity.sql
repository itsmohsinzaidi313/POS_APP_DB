

CREATE function [dbo].[funcTrialBalanceDebitActivity]
(
@Amount decimal(18,2),
@AccNature nvarchar(50)
)
returns decimal(18,2)
as
Begin

Declare @Final decimal(18,2);
set @Final =0;

if @AccNature = 'ASSETS' or @AccNature = 'EXPENSES'
Begin

if @Amount <= 0
Begin
set @Final =0;
End
else
Begin

set @Final = @Amount 

End
End

else if @AccNature = 'LIABILITIES' or @AccNature = 'OWNER EQUITY' or @AccNature = 'REVENUE'
Begin

if @Amount >= 0
Begin
set @Final =0;
End
else
Begin

set @Final = @Amount * (-1)

End
End

return @Final 
End


