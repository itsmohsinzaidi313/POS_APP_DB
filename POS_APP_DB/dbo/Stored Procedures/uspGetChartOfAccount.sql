create proc [dbo].[uspGetChartOfAccount]
@COId as int
as

--select CAId,AccNature,AccName,AccNo,[Type] as [Type],[Level] as [Level],0 as Balance,ParentId
--from ChartOfAccount where COId = @COId

select ca.CAId,ca.AccNature,ca.AccNo,ca.AccName,ca.[Type] as [Type],ca.[Level] as [Level],isnull(dbo.uspGetNetBalanceFunc(ca.CAId,@COId),0) as Balance,ca.ParentId,
(select id from AccountType where [Type] = ca.[Type]) as AccTypeId,
(select id from AccountNature where Account = ca.AccNature) as AccNatureId,
(select LevelId from AccountLevel where [Level] = ca.[Level] and COId = @COId) as AccLevelId,
ca.[Desc],
(select isnull(sum(Amount),0) from AccountOpenBalance where CAId = ca.CAId 
and APId = (select max(APId) from dbo.AccountPeriod where IsActive = 1 and COId = @COId)) as OpenBalance
--isnull([dbo].uspGetNetBalanceFunc(ca.CAId,@COId),0) as OpenBalance
from ChartOfAccount ca where COId = @COId
--order by ca.AccNature,Cast(ca.AccNo as nvarchar(50))
order by Cast(ca.AccNo as nvarchar(50))




