Create proc [dbo].[GetIssuanceNo]

as
select IssId,IssNo from IssuanceMaster_Store
order by IssNo


