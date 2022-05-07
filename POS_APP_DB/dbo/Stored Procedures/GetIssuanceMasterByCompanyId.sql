



CREATE proc [dbo].[GetIssuanceMasterByCompanyId]--76
@COId as int
as

select im.IssId,im.Date,im.IssNo,s.Store,b.Branch,b.BRId,isnull(d.DSId,0) as 'DSId',d.DSNo,im.DId,im.[Desc],dp.department_name as Department
from IssuanceMaster_Store im
inner join store s on im.SId = s.SId 
inner join Branch b on im.BRId = b.BRId
inner join DepartmentPos dp on im.DId = dp.id
left join DemandSheetMaster_Branch d on d.DSId = im.DSId
where s.COId = @COId