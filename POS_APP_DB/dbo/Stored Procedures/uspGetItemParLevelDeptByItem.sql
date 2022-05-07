CREATE proc [dbo].[uspGetItemParLevelDeptByItem]--61
@ItemId as int
as
select b.BRId,d.id,b.Branch,d.department_name as Department,
(select isnull(sum(parlevel),0) from ItemParlevel where BRId = b.BRId and SId = 0 and ItemId = ip.ItemId and DId = d.id) as ParLevel
from Branch b
inner join DepartmentPos d on b.BRId = d.BRId
inner join ItemParLevel ip on ip.DId = d.id
where ip.ItemId = @ItemId