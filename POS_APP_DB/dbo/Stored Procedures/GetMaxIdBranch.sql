CREATE proc [dbo].[GetMaxIdBranch]
as
select isnull (Max(BRId),0)from Branch

