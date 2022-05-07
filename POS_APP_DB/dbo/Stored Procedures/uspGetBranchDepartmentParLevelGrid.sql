create proc [dbo].[uspGetBranchDepartmentParLevelGrid]
@COId as int
as

select b.BRId,d.id,b.Branch,d.department_name as Department,cast(0 as decimal(18,2)) as ParLevel
from Branch b 
inner join DepartmentPos d on b.BRId = d.BRId
where b.COId = @COId