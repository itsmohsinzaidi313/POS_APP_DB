CREATE Proc [dbo].[DeleteBranchFromParlevel]
@BRId as int
as
delete from ItemParlevel

where BRId=@BRId