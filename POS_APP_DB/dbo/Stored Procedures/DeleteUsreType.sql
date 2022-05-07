CREATE PROC [dbo].[DeleteUsreType]
@UTId as int
as
Declare @Error as nvarchar(max);
Declare @UserType as nvarchar(max);
set @UserType='0';
Select @UserType=UserType from UserType where UTId=@UTId
if @UserType<>'0'
begin
Declare @UserTypeAccess as int;
set @UserTypeAccess=0;
Select @UserTypeAccess= count(UserTypeAccessId) from UserTypeAccess where UTId=@UTId
if @UserTypeAccess=0
begin


delete from UserType where UTId=@UTId
declare @Cheack as nvarchar(max);
set @Cheack='0';
select @Cheack=UserType from UserType where UTId=@UTId
if @Cheack='0'
begin
set @Error='UserType Deleted Successfully'
Select @Error
end

end
else
begin
set @Error='Unable To Delete Because UserTypeAccess Exists Against This UserType'
Select @Error
end
end
else 
begin
set @Error= 'UserType Not found'
Select @Error
end
