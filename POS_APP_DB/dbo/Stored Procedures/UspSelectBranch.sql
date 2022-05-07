CREATE proc [dbo].[UspSelectBranch]
as
select BRId,Company,Branch,Company.COId,IsPosSelected from Branch 
inner join Company on
Branch.COId=Company.COId


