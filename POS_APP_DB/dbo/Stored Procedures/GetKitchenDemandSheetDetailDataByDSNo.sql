CREATE Proc [dbo].[GetKitchenDemandSheetDetailDataByDSNo]
@KDSNo as nvarchar(50)
as
Select i.ItemId,i.Item,u.Unit,u.UId,dsd.Qty as DemandQty, i.[Type] as ItemType
from DemandSheetMaster_Branch dsm
inner join DemandSheetDetail_Branch dsd on dsm.DSId=dsd.DSId
inner join Item i on dsd.ItemId=i.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.IssUnit=u.Uid
--inner join Butchery bu on bu.Id=i.[Type]
where dsm.DSNo=@KDSNo