CREATE proc [dbo].[UspBindBranch]
as
select BRId,Branch,Company.COId from Branch 
inner join Company on
Branch.COId=Company.COId