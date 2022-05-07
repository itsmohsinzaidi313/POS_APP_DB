create proc [dbo].[uspGetAccountDetail]
as
select ca.CAId,ca.AccNature as Main,(select AccName from ChartOfAccount where CAId = 
(select ParentId from ChartOfAccount where CAId = ca.ParentId)) as [Group],
(select AccName from ChartOfAccount where CAId = ca.ParentId) as SubGroup,
ca.AccName as Account,ca.AccNo as Account_No
from ChartOfAccount ca 
where ca.[Type] = 'DETAIL'
order by cast(ca.AccNo as nvarchar(50))

