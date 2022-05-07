Create proc [dbo].[UspBindPRNoDate]--'6/26/2013 12:00:00 AM','7/28/2013 12:00:00 AM'
@From as datetime,
@To as Datetime
as
select 
pm.PRId,pm.PRNo from ProductionMaster pm
where Date between @From and @To

