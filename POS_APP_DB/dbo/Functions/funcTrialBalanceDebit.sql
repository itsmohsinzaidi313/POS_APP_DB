create function [dbo].[funcTrialBalanceDebit]
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
set @Final = @Amount
End

return @Final 
End









