create proc [dbo].[uspGetProfitLossBySectionByToDate]

@Section as nvarchar(50),
--@DateFrom as datetime,
@DateTo as datetime,
--@Debit as nvarchar(10),
--@Credit as nvarchar(10),
@COId as int

as
--Declare @DateFrom datetime;
--Declare @DateTo datetime;
--Declare @Section nvarchar(50);
--Declare @Debit nvarchar(10);
--Declare @Credit nvarchar(10);
--Declare @COId int;
--set @COId = '1';
--set @DateFrom = '2013-07-23 00:00:00.000';
--set @DateTo = '2013-07-23 00:00:00.000';
--set @Debit = 'C';
--set @Credit = 'D'
--set @Section = 'Section 3';
select ca.CAId,
(select AccNature from ChartOfAccount where AccName = ca.AccName) as Main,
(select AccName from ChartOfAccount where CAId = 
(select ParentId from ChartOfAccount where CAId = ca.ParentId)) as [Group],
(select AccName from ChartOfAccount where CAId = ca.ParentId) as SubGroup,
(select Title from ProfitLossSettings where Section = @Section) as Title,ca.AccNo,ca.AccName,
--((select isnull(sum(Amount),0) from gl 
--where Date between @DateFrom and @DateTo and [Type] = @Debit 
--and CAId = ca.CAId)
---
--(select isnull(sum(Amount),0) from gl 
--where Date between @DateFrom and @DateTo and [Type] = @Credit
--and CAId = ca.CAId))

isnull([dbo].funcGetNetBalanceByDate(ca.CAId,@DateTo,ca.COId),0)

as Amount,
@DateTo as DateTo,Cast(0 as decimal(18,2)) as PrevSum
from ChartOfAccount ca
--inner join GL gl on ca.CAId = gl.CAId
where ca.AccNo between 
(select AccNoFrom from ProfitLossSettings where Section = @Section) 
and (select AccNoTo from ProfitLossSettings where Section = @Section)
--and gl.Date between @DateFrom and @DateTo 
and ca.COId = @COId
group by ca.CAId,ca.AccNo,ca.AccName,ca.ParentId,ca.COId
