CREATE PROC [dbo].[UpdateUsreType]
@UTId as int,
@COId as int,
@Sid as int,
@UserType as nvarchar(50)
as
Update UserType set 

COId=@COId,
--Sid=@Sid,
UserType=@UserType

where UTId=@UTId



