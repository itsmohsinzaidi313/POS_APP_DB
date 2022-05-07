create function [dbo].[uspGetNetOpenBalanceFunc]
(
@AccountNo  int,
@COId  int,
@DateFrom datetime
)
returns decimal(18,2)
as
Begin

Declare @FiscalId int;
Declare @OpenBalance decimal(18,2);
Declare @AccountType  varchar(50);
Declare @NetBalance decimal(18,2);
Declare @Debit decimal(18,2);
Declare @Credit decimal(18,2);
Declare @FinalNetOpenBalance decimal(18,2);

set @FinalNetOpenBalance =0;

select @FiscalId = max(APId) from AccountPeriod where IsActive = 1 and COId = @COId
select @OpenBalance = isnull(Amount,0) from AccountOpenBalance where APId = @FiscalId and CAId = @AccountNo
select @AccountType = AccNature from ChartOfAccount where CAId = @AccountNo and COId = @COId
select @Debit = isnull(sum(Amount),0) from GL where [Type] = 'D' and CAId = @AccountNo and COId = @COId and Date < @DateFrom
select @Credit = isnull(sum(Amount),0) from GL where [Type] = 'C' and CAId = @AccountNo and COId = @COId and Date < @DateFrom
if (@AccountType = 'ASSETS' OR @AccountType = 'EXPENSES') begin 
set @NetBalance = @Debit - @Credit end 
else if (@AccountType = 'LIABILITIES' OR @AccountType = 'REVENUE' OR @AccountType = 'OWNER EQUITY') begin 
set @NetBalance = @Credit - @Debit end 

set @FinalNetOpenBalance = @NetBalance + @OpenBalance
return @FinalNetOpenBalance 
End



