Create proc [dbo].[UspBindGRNDate]--'6/26/2013 12:00:00 AM','7/28/2013 12:00:00 AM'
@From as datetime,
@To as Datetime
as
select 
GRN.GRNId,GRN.GRNo from GRNMaster GRN
where Date between @From and @To
