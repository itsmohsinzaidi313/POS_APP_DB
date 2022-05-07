CREATE Proc [dbo].[GetPRDetailDataByPRNO]--'PR-0001'
@GRNo as nvarchar(50)
as
Select i.ItemId,i.Item,u.Unit,u.UId,dsd.Qty,dsd.Rate as RatePerPcs,dsd.TotalPackage
,dsd.PcsPerPackage,dsd.RatePerPackage,
Cast( Round((dsd.Qty*dsd.Rate),2) AS DECIMAL (18,2))as Amount,
dsd.POId,po.PONo as PONo,dsd.PackageId
,(select Unit from Unit where Uid=dsd.PackageId)as [Type],
dsd.Tax,dsd.Discount,dsd.ActualRate as NetRatePerPcs,dsd.TaxType

from PurchaseReturnMasterNew dsm
inner join PurchaseReturnDetailNew dsd on dsm.PRId=dsd.PRId
inner join Item i on dsd.ItemId=i.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.PurUnit=u.Uid
left join PurchaseOrderMaster_Store po on dsd.POId=po.POId
where dsm.PRNo=@GRNo