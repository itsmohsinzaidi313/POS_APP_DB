Create proc [dbo].[UspBindIssDate]--'6/26/2013 12:00:00 AM','7/28/2013 12:00:00 AM'
@From as datetime,
@To as Datetime
as
select 
Iss.IssId,Iss.IssNo from IssuanceMaster_Store Iss
where Date between @From and @To
