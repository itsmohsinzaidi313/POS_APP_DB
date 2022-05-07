
CREATE PROC [dbo].[InsertUsreType]
@UserType as nvarchar(50),
@COId as int,
@Sid as int
as
Insert into UserType (UserType,COId) values(@UserType,@COId) 
Select Scope_Identity();


