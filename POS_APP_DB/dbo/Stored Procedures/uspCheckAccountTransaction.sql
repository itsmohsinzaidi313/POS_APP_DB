create proc [dbo].[uspCheckAccountTransaction]--128,1
@CAId as int,
@COId as int
as
Declare @Type nvarchar(50);
Declare @count int;
set @count = 0;

select @Type = [Type] from ChartOfAccount where CAId = @CAId and COId = @COId
if @Type = 'GROUP'
Begin
select @count = count(caid) from ChartOfAccount where ParentId = @CAId and COId = @COId
End
else if @Type = 'SUB GROUP'
Begin
select @count = count(caid) from ChartOfAccount where ParentId = @CAId and COId = @COId
End

else if @Type = 'DETAIL'
Begin

select @count = count(caid) from gl where CAId = @CAId and COId = @COId

if @count = 0
Begin
select @count = count(caid) from AccountOpenBalance where CAId = @CAId and Amount > 0
End


--select * from AccountOpenBalance a
--right join gl g on a.CAId = g.CAId
--where a.CAId = @CAId  and a.Amount < 0
End

select @count as [Count]
