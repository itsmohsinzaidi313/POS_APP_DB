CREATE Proc [dbo].[CheackUserLogin]
@UserName as nvarchar(max),
@Password as nvarchar(max)
--,
--@Store as int,
--@Branch as int
as
--Declare @Error as nvarchar(max);
--set @Error ='Invalid User Name or Password !'
--if @Store > 0 and @Branch > 0
--begin
Select ut.UserType,u.UserId
--,c.COId,s.SId,'0' as BRId 
from [User] u
inner join UserType ut on u.UTId=ut.UTId
--inner join Company c on ut.COId=c.COId
--inner join Store s on c.COId=s.COId
where  
--s.IsSelected=1 and  
u.UserName=@UserName and u.Password=@Password 
--end
--else
--begin
--select @Error
--end


--select * from [User]
--select * from UserType
--select * from Company
--select * from Store
--
--[CheackUserLogin]'admin','123',80,0
--
--
--Select ut.UserType,u.UserId,c.COId,s.SId,'0' as BRId from [User] u
--inner join UserType ut on u.UTId=ut.UTId
--inner join Company c on ut.COId=c.COId
--inner join Store s on c.COId=s.COId
--where  s.IsSelected=1 and  u.UserName='admin' and u.Password='123' 



