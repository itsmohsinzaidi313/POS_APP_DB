CREATE Proc [dbo].[GetPruchaseReturnDetail]--'INV-0002'
@PRNo as nvarchar(50)
as
Select i.ItemId,i.Item,u.Unit,u.UId,isd.Qty,isd.Rate as RatePerPcs,isd.TotalPackage,
isd.PcsPerPackage,isd.RatePerPackage,
Cast( Round((isd.Qty*isd.Rate),2) AS DECIMAL (18,2))as Amount,
isd.POId,po.PONo as PONO,isd.PackageId,gm.GRNo as GRNo,isd.GRNId
,(select Unit from Unit where Uid=isd.PackageId)as Type
from PurchaseReturnMaster ism
inner join PurchaseReturnDetail isd on isd.PRId=ism.PRId
inner join Item i on isd.ItemId=i.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.PurUnit=u.Uid
inner join PurchaseOrderMaster_Store po on isd.POId=po.POId
inner join GRNMaster gm on isd.GRNId=gm.GRNId
where ism.PRNo=@PRNo










