CREATE proc [dbo].[UspBindPOStoreDate]--'6/26/2013 12:00:00 AM','7/28/2013 12:00:00 AM'
@From as datetime,
@To as Datetime
as
select 
pom.POId,pom.PONo from PurchaseOrderMaster_Store pom
where Date between @From and @To
