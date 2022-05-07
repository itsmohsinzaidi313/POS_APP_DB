
Create PROC [dbo].[InsertUsreTypeAccess]
@Functions as nvarchar(50),
@UTid as int,
@IsActive as bit
as
Insert into UserTypeAccess (Functions,UTid,IsActive) values(@Functions,@UTid,@IsActive) 
Select Scope_Identity();

