create proc [dbo].[uspBalanceSheetByDate]
@DateTo as datetime,
@COId as int
as
--Declare @DateTo datetime;
--set @DateTo = Cast('2013-07-24 00:00:00.000' as datetime)

select ca.CAId,ca.AccNature as Main,(select AccName from ChartOfAccount where CAId = 
(select ParentId from ChartOfAccount where CAId = ca.ParentId)) as [Group],
(select AccName from ChartOfAccount where CAId = ca.ParentId) as SubGroup,
ca.AccName as Account,ca.AccNo as Account_No,
Cast(isnull([dbo].funcGetNetBalanceByDate(ca.CAId,@DateTo,@COId),0) as decimal(18,2)) as NetBalance,
--Cast(isnull([dbo].funcTrialBalanceDebit(Cast(isnull([dbo].funcGetNetBalanceByDate(ca.CAId,@DateTo,@COId),0) as decimal(18,2)),ca.AccNature),0) as decimal(18,2)) as Debit,
--Cast(isnull([dbo].funcTrialBalanceCredit(Cast(isnull([dbo].funcGetNetBalanceByDate(ca.CAId,@DateTo,@COId),0) as decimal(18,2)),ca.AccNature),0) as decimal(18,2)) as Credit,
@DateTo as DateTo
from ChartOfAccount ca 
where ca.[Type] = 'DETAIL'
order by cast(ca.AccNo as nvarchar(50))



--[uspBalanceSheetByDate]'2013-07-31 00:00:00.000',1
