
create proc [dbo].[UspBindPRNoDeptByDate]
@From as datetime,
@To as Datetime
as
select 
pm.PRId,pm.PRNo from ProductionMasterDepartment pm
where Date between @From and @To


