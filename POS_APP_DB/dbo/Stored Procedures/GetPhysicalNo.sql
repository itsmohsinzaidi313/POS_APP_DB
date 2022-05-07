
CREATE proc [dbo].[GetPhysicalNo]

as
select PSId,PSNO,Date,[Desc] from PhysicalStockMaster_Store
order by PSNO





