Create proc [dbo].[UspBindStore]
as

select SId,Store,Company.COId from Store 
inner join Company on
Store.COId=Company.COId