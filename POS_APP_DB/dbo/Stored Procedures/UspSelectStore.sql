CREATE proc [dbo].[UspSelectStore]
as
select SId, Company,Company.COId,Store,CentarlStore from Store
inner join Company on
Company.COId=Store.COId





