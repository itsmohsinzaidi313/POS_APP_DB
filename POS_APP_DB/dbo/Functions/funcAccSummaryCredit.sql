create function [dbo].[funcAccSummaryCredit]
(
@Amount decimal(18,2),
@Type nvarchar(10)
)
returns decimal(18,2)
as
Begin

Declare @Final decimal(18,2);
set @Final =0;

if @Type = 'C'
Begin
set @Final = @Amount
End

return @Final 
End




