CREATE proc [dbo].[GetStoreByCompany]
as
Select s.sid,s.Store from Company c  inner join Store s on s.COId=c.COId where s.CentarlStore=1 and C.IsSelected=1

