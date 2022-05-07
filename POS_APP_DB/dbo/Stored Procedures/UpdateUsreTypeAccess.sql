Create PROC [dbo].[UpdateUsreTypeAccess]
@UserTypeAccessId as int,
@Functions as nvarchar(50),
@UTid as int,
@IsActive as bit
as
Update UserTypeAccess set 

Functions=@Functions,
UTid=@UTid,
IsActive=@IsActive

where UserTypeAccessId=@UserTypeAccessId


