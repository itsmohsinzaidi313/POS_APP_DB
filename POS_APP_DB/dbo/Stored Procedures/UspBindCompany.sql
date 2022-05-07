Create proc [dbo].[UspBindCompany]
as
select COId,Company from Company order by Company asc
