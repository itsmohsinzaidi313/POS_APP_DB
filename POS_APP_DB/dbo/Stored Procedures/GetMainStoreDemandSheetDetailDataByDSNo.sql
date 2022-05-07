Create Proc [dbo].[GetMainStoreDemandSheetDetailDataByDSNo]
@DSNo as nvarchar(50)
as
Select i.ItemId,i.Item,u.Unit,u.UId,dsd.Qty as DemandQty
from DemandSheetMaster_Store dsm
inner join DemandSheetDetail_Store dsd on dsm.DSCOId=dsd.DSCOId
inner join Item i on dsd.ItemId=i.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.PurUnit=u.Uid
where dsm.DSNo=@DSNo
