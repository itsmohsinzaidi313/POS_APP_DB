Create proc [dbo].[UspBindGrnSingleDate]--'6/26/2013 12:00:00 AM','7/28/2013 12:00:00 AM'
@Date as datetime
as
select 
GRNId,GRNo from GRNMaster 
where Date=@Date

