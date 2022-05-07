Create proc [dbo].[UspBindStores]
as
select SId , Store from Store
order by Store