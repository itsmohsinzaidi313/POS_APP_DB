CREATE Proc [dbo].[GetUserType]
as
--Select UTId,UserType,Company.COId,Store.SId,Store.Store,Company.Company
--from [UserType]  
--inner join Store   
--on Store.Sid=UserType.Sid
--inner join Company   
--on Company.COId=UserType.COId

Select UTId,UserType,Company.COId,Store.SId,Store.Store,Company.Company
from [UserType]  
inner join Store   
on Store.COId=UserType.COId
inner join Company   
on Company.COId=UserType.COId


--where Store.Isselected='false'