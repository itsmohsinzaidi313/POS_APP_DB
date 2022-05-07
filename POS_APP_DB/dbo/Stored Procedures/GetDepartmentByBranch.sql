create proc [dbo].[GetDepartmentByBranch]
@BRId as int
as

select d.id,d.department_name as Department,b.Branch,c.Company,b.BRId
from DepartmentPOS d
inner join Branch b on d.BRId = b.BRId
inner join Company c on c.COId = b.COId
where d.BRId = @BRId