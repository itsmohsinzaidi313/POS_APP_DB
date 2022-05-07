create proc [dbo].[BindBranchAgaintsCompany]
@COId as int
as
select BRId,Branch,Company.COId  from Branch
inner join Company on
Company.COId=Branch.COId
where Company.COId =@COId


