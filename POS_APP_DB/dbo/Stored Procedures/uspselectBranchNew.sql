create proc [dbo].[uspselectBranchNew]
as
select top 1 * from branch
where isSelected='true'