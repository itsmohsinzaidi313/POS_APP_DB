create proc [dbo].[UspGetCentralStore]
as
select CentarlStore from Store
where CentarlStore='True'

