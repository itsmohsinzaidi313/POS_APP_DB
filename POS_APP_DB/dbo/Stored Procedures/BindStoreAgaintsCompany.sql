create proc [dbo].[BindStoreAgaintsCompany]
@COId as int
as
select sid,store,Company.COId  from store
inner join Company on
Company.COId=store.COId
where Company.COId =@COId

