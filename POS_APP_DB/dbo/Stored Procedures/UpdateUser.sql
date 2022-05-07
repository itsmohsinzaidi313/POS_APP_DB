CREATE Proc [dbo].[UpdateUser]
@UserId as int,
@UTId as int,
@UserName as nvarchar(50),
@Password as nvarchar(50)
as

update [User]
set
UTId=@UTId,
UserName=@UserName,
Password=@Password


where UserId=@UserId