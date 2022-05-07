CREATE proc [dbo].[UspBindPhysicalBranchStock]
@PSNO as nvarchar(50)
as
select i.ItemId,i.Item,u.UId,u.Unit,Qty,Amount
from PhysicalStockMaster_Branch psb
inner join PhysicalStockDetail_Branch Psdb on psb.PSBRId=Psdb.PSBRId
inner join Item i on Psdb.ItemId=i.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.PurUnit=u.Uid
where psb.PSNO=@PSNO

