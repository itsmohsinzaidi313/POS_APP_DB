CREATE proc [dbo].[UspBindDSOnEW]
as
select DSCOId,DSNo from DemandSheetMaster_Store DS

WHERE EXISTS
(
select * from DemandSheetDetail_Store DSD where DSD.DSCOId = DS.DSCOId and DSD.Status = 0 
)
order by DS.DSNo