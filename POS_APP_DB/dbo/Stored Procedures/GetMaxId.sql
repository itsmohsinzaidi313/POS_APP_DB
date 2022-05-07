CREATE proc [dbo].[GetMaxId]
as
select isnull (Max (SId),0) from store
