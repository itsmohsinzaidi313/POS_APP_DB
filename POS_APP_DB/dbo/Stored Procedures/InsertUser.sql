CREATE Proc [dbo].[InsertUser]
@UTId as int,
@UserName as nvarchar(50),
@Password as nvarchar(50)
as
insert into [User](UserName,Password,UTId)
values(@UserName,@Password,@UTId) Select Scope_Identity();
