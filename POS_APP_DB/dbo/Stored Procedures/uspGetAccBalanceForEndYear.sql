create proc [dbo].[uspGetAccBalanceForEndYear]
@COId as int

as
select ca.CAId,ca.AccNature,ca.AccName,ca.AccNo,ca.[Type] as [Type],ca.[Level] as [Level],isnull(dbo.funcGetNetBalanceForEndYear(ca.CAId,@COId),0) as Balance,ca.COid
from ChartOfAccount ca 
where COId = @COId 
--and ca.AccNature <> 'OWNER EQUITY' and ca.AccNature <> 'REVENUE' and ca.AccNature <> 'EXPENSES' 
and ca.[Type] = 'DETAIL'
order by ca.AccNature,Cast(ca.AccNo as nvarchar(50))
