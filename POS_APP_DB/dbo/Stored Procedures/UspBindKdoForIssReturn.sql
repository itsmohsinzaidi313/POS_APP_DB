create proc [dbo].[UspBindKdoForIssReturn]
as
select ism.DSId ,dm.DSNo from IssuanceMaster_Store ism

inner join DemandSheetMaster_Branch dm
on  ism.DSId=dm.DSId