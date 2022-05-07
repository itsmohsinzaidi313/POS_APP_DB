CREATE proc [dbo].[UspGetInventoryLogin]
as
select top 1 b.BRId as BRId, c.COId
--(select  from branch b)
,SId from Company c
left join Store s on c.COId=s.COId
left join Branch b on c.COId=b.COId
--New Work
where s.CentarlStore='True'



