CREATE proc [dbo].[GetDepartment]
as

--select * from Branch
--select * from Company
--Select * from DepartmentPOS


select d.id,d.department_name as Department,b.Branch,c.Company,b.BRId
from DepartmentPOS d
inner join Branch b on d.BRId = b.BRId
inner join Company c on c.COId = b.COId
