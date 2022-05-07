CREATE proc [dbo].[UspBindPhysicalStock]
@PSNO as nvarchar(50)
as
select 
--psm.PSId, 
i.ItemId,i.Item,u.UId,u.Unit,Qty,Amount
from PhysicalStockMaster_Store psm
inner join PhysicalStockDetail_Store Psd on psm.PSId=Psd.PSId
inner join Item i on Psd.ItemId=i.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.PurUnit=u.Uid
where psm.PSNO=@PSNO

