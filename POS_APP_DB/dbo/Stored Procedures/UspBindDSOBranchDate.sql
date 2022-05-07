CREATE proc [dbo].[UspBindDSOBranchDate]--'6/26/2013 12:00:00 AM','7/28/2013 12:00:00 AM'
@From as datetime,
@To as Datetime
as
select 
dmb.DSId,dmb.DSNo from DemandSheetMaster_Branch dmb
where Date between @From and @To