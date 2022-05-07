CREATE Proc [dbo].[GetGRNDetailDataByGRNONew]--'GRN-0001'
@GRNo as nvarchar(50)
as
Select i.ItemId,i.Item,u.Unit,u.UId,dsd.Qty,dsd.Rate as RatePerPcs,dsd.TotalPackage
,dsd.PcsPerPackage,dsd.RatePerPackage,
Cast( Round((dsd.Qty*dsd.Rate),2) AS DECIMAL (18,2))as Amount,

dsd.POId,po.PONo as PONO,dsd.PackageId
,(select Unit from Unit where Uid=dsd.PackageId)as Type 
from GRNMaster dsm
inner join GRNDetail dsd on dsm.GRNId=dsd.GRNId
inner join Item i on dsd.ItemId=i.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.PurUnit=u.Uid
inner join PurchaseOrderMaster_Store po on dsd.POId=po.POId
where dsm.GRNo=@GRNo





