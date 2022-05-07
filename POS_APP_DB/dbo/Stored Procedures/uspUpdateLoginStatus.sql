create proc [dbo].[uspUpdateLoginStatus]

@UserName as nvarchar(50)
as

Update tbl_user set loginstatus = 0 where username = @UserName