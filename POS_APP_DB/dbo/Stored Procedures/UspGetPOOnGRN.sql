
CREATE proc [dbo].[UspGetPOOnGRN]
@PONo as nvarchar(50)
as
select Pom.POId, Pom.PONo,Pom.Date,i.Item,i.ItemId,U.Uid,U.Unit,
--Pod.Qty,
(Pod.Qty - isnull((select sum(Qty) from GRNDetail where POId = Pom.POId and ItemId = i.ItemId),0)) as Qty,

Pod.Rate from PurchaseOrderMaster_Store Pom
inner join  PurchaseOrderDetail_Store Pod on
Pod.POId=Pom.POId
inner join  Item i on
i.ItemId=Pod.ItemId
inner join  Unit u on
u.UId=Pod.UId
where Pom.PONo=@PONo