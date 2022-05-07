CREATE Proc [dbo].[GetUser]

as
Select u.UserId,u.UserName,u.Password,ut.UserType,ut.UTId from 
[User] u inner join UserType  ut on u.UTId=ut.UTId 
