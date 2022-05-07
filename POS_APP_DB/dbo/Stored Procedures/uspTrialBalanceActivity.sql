

CREATE proc [dbo].[uspTrialBalanceActivity]
@DateFrom as datetime,
@DateTo as datetime,
@COId as int,
@ZeroBalance as int
as
Declare @ZeroBalAccount nvarchar(50);
set @ZeroBalAccount = null;

if @ZeroBalance = 1
Begin
set @ZeroBalAccount = 'Leave Zero Balance Accounts';
End
else if @ZeroBalance = 0
Begin
set @ZeroBalAccount = '';
End

select ca.CAId,ca.AccNature as Main,
(select AccName from ChartOfAccount where CAId = 
(select ParentId from ChartOfAccount where CAId = ca.ParentId)) as [Group],

(select AccNo from ChartOfAccount where CAId = 
(select ParentId from ChartOfAccount where CAId = ca.ParentId)) as GroupAccount_No,

(select AccName from ChartOfAccount where CAId = ca.ParentId) as SubGroup,
(select AccNo from ChartOfAccount where CAId = ca.ParentId) as SubGroupAccount_No,
ca.AccName as Account,ca.AccNo as Account_No,ca.[Level],


Cast(isnull([dbo].funcTrialBalanceDebitActivity(Cast(isnull([dbo].funcGetNetBalanceByDate(ca.CAId,(@DateFrom - 1),@COId),0) as decimal(18,2)),ca.AccNature),0) as decimal(18,2)) as OpenBalanceDebit,
Cast(isnull([dbo].funcTrialBalanceCreditActivity(Cast(isnull([dbo].funcGetNetBalanceByDate(ca.CAId,(@DateFrom - 1),@COId),0) as decimal(18,2)),ca.AccNature),0) as decimal(18,2)) as OpenBalanceCredit,

Cast((select isnull(sum(Amount),0) from gl where CAId = ca.CAId and [Type] = 'D' and 
date between @DateFrom and @DateTo) as decimal(18,2)) as ActivityDebit,
Cast((select isnull(sum(Amount),0) from gl where CAId = ca.CAId and [Type] = 'C' and 
date between @DateFrom and @DateTo) as decimal(18,2)) as ActivityCredit,

Cast(isnull([dbo].funcTrialBalanceDebitActivity(Cast(isnull([dbo].funcGetNetBalanceByDate(ca.CAId,@DateTo,@COId),0) as decimal(18,2)),ca.AccNature),0) as decimal(18,2)) as ClosingDebit,
Cast(isnull([dbo].funcTrialBalanceCreditActivity(Cast(isnull([dbo].funcGetNetBalanceByDate(ca.CAId,@DateTo,@COId),0) as decimal(18,2)),ca.AccNature),0) as decimal(18,2)) as ClosingCredit
,@DateFrom as DateFrom,@DateTo as DateTo,'0' as FromAccountCode,'0' as ToAccountCode,@ZeroBalAccount as ZeroBalAccount,co.Company

from ChartOfAccount ca 
inner join company co on ca.coid = co.coid
where ca.[Type] = 'DETAIL'
order by cast(ca.AccNo as nvarchar(50))