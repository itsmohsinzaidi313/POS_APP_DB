create proc [dbo].[GetStoreKitchen]
as
Select s.sid,s.Store from Company c  
inner join Store s on s.COId=c.COId where s.CentarlStore=0 and C.IsSelected=1

