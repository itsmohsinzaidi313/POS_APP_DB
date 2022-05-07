Create proc [dbo].[UspBindPhBranchDate]--'6/26/2013 12:00:00 AM','7/28/2013 12:00:00 AM'
@From as datetime,
@To as Datetime
as
select 
Phb.PSBRId,Phb.PSNO from PhysicalStockMaster_Branch Phb
where Date between @From and @To
