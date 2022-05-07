
CREATE proc [dbo].[GetPhysicalBranchNo]

as

select psb.PSBRId,psb.PSNO,psb.Date,br.Branch as Kitchen,psb.BRId,psb.DId,psb.[Desc],dp.department_name as Department
from PhysicalStockMaster_Branch psb
inner join Branch br on psb.BRId = br.BRId
inner join DepartmentPos dp on psb.DId = dp.id
order by psb.PSNO

--select PSBRId,PSNO,Date from PhysicalStockMaster_Branch
--order by PSNO

