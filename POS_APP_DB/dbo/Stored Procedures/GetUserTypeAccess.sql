CREATE Proc [dbo].[GetUserTypeAccess]
--@UTid as int
as
Select UserTypeAccessId,Functions,UserTypeAccess.IsActive,UserType.UTid,UserType.UserType
 from UserTypeAccess  inner join UserType   
on UserType.UTid=UserTypeAccess.UTid


