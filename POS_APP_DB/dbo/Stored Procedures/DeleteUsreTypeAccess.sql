Create PROC [dbo].[DeleteUsreTypeAccess]
@UserTypeAccessId as int
as
Delete from UserTypeAccess  where UserTypeAccessId=@UserTypeAccessId 

