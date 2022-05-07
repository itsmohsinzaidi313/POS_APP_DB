Create proc [dbo].[UspBindDSOBranchNew]
as
select DSId,DSNo from DemandSheetMaster_Branch db

 Where NOT EXISTS
(
select * from IssuanceMaster_Store where DSId = db.DSId
)


