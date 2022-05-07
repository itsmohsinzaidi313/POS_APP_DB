CREATE proc [dbo].[uspGetBranchDepartmentParLevelGridByItem]
@COId as int,
@DId as int
as

select b.BRId,b.Branch,d.id as DId,d.department_name as Department,i.ItemId,i.Item,
(select isnull(sum(parlevel),0) from ItemParlevel where BRId = b.BRId and SId = 0 and ItemId = i.ItemId)
as Parlevel
from Item i
inner join Subcategory sc on i.SBId =sc.SBId
inner join category c on sc.CId =c.CId
inner join Company cc on c.COId = cc.COId
inner join Branch b on b.COId = b.COId
inner join DepartmentPOS d on d.BRId = b.BRId
where cc.COId = @COId and d.id = @DId
group by d.department_name,b.BRId,b.Branch,i.ItemId,i.Item,d.id ,b.BRId