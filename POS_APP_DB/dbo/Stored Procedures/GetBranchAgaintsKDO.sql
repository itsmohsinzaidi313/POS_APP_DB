Create proc [dbo].[GetBranchAgaintsKDO]--'GRN-0001'
@DSNo as nvarchar(50)
as
select b.BRId,b.Branch from Branch b 
inner join DemandSheetMaster_Branch dsm on
b.BRId=dsm.BRId
where DSNo=@DSNo 