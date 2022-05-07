CREATE proc [dbo].[UspBindDSOStoreDate]--'6/26/2013 12:00:00 AM','7/28/2013 12:00:00 AM'
@From as datetime,
@To as Datetime
as
select 
dms.DSCOId,dms.DSNo from DemandSheetMaster_Store dms
where Date between @From and @To
