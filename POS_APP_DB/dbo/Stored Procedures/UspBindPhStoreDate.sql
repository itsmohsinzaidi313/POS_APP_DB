Create proc [dbo].[UspBindPhStoreDate]--'6/26/2013 12:00:00 AM','7/28/2013 12:00:00 AM'
@From as datetime,
@To as Datetime
as
select 
Phs.PSId,Phs.PSNO from PhysicalStockMaster_Store Phs
where Date between @From and @To
