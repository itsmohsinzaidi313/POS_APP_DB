
CREATE proc [dbo].[GetInventoryAdjusmentBranchNo]

as
select inb.AdjBRId,inb.AdjNo,inb.Date,b.Branch,inb.BRId,inb.DId,dp.department_name as Department,inb.[Desc] 
from InvAdjMaster_Branch inb
inner join Branch b on inb.BRId = b.BRId
inner join Departmentpos dp on inb.DId = dp.id
where inb.IsApprove = 0
order by inb.AdjNo



