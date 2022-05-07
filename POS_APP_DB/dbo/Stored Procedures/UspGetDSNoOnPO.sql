
CREATE proc [dbo].[UspGetDSNoOnPO]
@DSNo as nvarchar(50)
as
select dsm.DSCOId,Dsm.DSNo,Dsm.Date,i.Item,i.ItemId,u.Unit,u.UId
,(Dsd.Qty - isnull((select sum(Qty) from PurchaseOrderDetail_Store where DSCOId = dsm.DSCOId and ItemId = i.ItemId),0)) as Qty
from DemandSheetMaster_Store Dsm
inner join  DemandSheetDetail_Store Dsd on
Dsd.DSCOId=Dsm.DSCOId
inner join  Item i on
i.ItemId=Dsd.ItemId
inner join  Unit u on
u.UId=Dsd.Unit
where Dsm.DSNo=@DSNo