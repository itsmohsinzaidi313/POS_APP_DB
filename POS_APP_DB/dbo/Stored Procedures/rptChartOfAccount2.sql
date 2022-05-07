create proc [dbo].[rptChartOfAccount2]
@COId as int
as
select 
ca.CAId,ca.AccNature,ca.AccName,ca.AccNo,ca.[Type] as [Type],ca.[Level] as [Level],ParentId,
isnull(dbo.uspGetNetBalanceFunc(ca.CAId,@COId),0) as Balance,
(select isnull(sum(Amount),0) from AccountOpenBalance where CAId = ca.CAId 
and APId = (select APId from dbo.AccountPeriod where IsActive = 1 and COId = @COId)) as OpenBalance
from ChartOfAccount ca where COId = @COId
order by ca.AccNature,Cast(ca.AccNo as nvarchar(50))



