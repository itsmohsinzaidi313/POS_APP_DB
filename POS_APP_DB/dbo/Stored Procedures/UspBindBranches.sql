Create proc [dbo].[UspBindBranches]
as
select BRId , Branch from Branch
order by Branch