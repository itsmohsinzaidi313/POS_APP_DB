CREATE Proc [dbo].[DeleteUser]
@UTId as int,
@UserId as int
as
Delete from [User] where UserId=@UserId and UTId=@UTId

