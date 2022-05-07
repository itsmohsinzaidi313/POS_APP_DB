create function [dbo].[funcAccSummaryBalance]
(
@Open decimal(18,2),
@Debit decimal(18,2),
@Credit decimal(18,2),
@AccType nvarchar(10)
)
returns decimal(18,2)
as
Begin

Declare @Final decimal(18,2);
set @Final =0;

if @AccType = 'ASSETS' or @AccType = 'EXPENSES'
Begin
set @Final = @Open + (@Debit - @Credit)
End
else
Begin
set @Final = @Open + (- @Debit + @Credit)
End

return @Final 
End










