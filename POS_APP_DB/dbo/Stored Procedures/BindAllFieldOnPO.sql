CREATE proc [dbo].[BindAllFieldOnPO]--'PO-0002'
@PONo as nvarchar(50)
as
Select i.ItemId,i.Item,u.UId,u.Unit,Dsm.DSNo,Pod.DSCOId,Pod.Rate,Pod.Qty as TotalPcs,Pod.Amount
--,Pom.POId,POm.VId
,isnull((select Status from DemandSheetDetail_Store where ItemId = i.ItemId and DSCOId = Pod.DSCOId),'False') as Status
from PurchaseOrderMaster_Store POm
inner join PurchaseOrderDetail_Store Pod on POm.POId=Pod.POId
inner join Item i on Pod.ItemId=i.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.PurUnit=u.Uid
inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
left join DemandSheetMaster_Store Dsm on Dsm.DSCOId=Pod.DSCOId
--inner join DemandSheetDetail_Store Dsd on Dsm.DSCOId=Dsd.DSCOId
where POm.PONo=@PONo and ipl.BRId = 0 and ipl.SId > 0
 --POd.POId = 116 (select POId from PurchaseOrderMaster_Store where PONo =@PONo)
group by 
i.ItemId,i.Item,u.UId,u.Unit,Dsm.DSNo,Pod.DSCOId,Pod.Rate,Pod.Qty
,Pod.Amount,Pom.POId--,Dsd.Status

