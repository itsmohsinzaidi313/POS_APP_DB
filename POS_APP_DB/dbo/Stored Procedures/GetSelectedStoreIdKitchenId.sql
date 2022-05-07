create proc [dbo].[GetSelectedStoreIdKitchenId]

as

select 
(select SId from Store where IsSelected = 1) as SId,
(select BRId from Branch where IsSelected = 1) as BRId