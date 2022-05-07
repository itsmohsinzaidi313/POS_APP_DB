
CREATE proc [dbo].[GetInventoryAdjusmentStoreNo]

as
select AdjId,AdjNo,Date,[Desc] from InvAdjMaster_Store
where IsApprove = 0
order by AdjNo









