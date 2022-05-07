
CREATE Proc [dbo].[ReportDSNoWiseReceivingReport]--'6/26/2013 12:00:00 AM','6/29/2013 12:00:00 AM','Admin','10'
@DSNOId as nvarchar(50),
@Login as nvarchar(max),
@SId as int
as
select @Login as LoginUser,gm.Date,gm.GRNo,v.Vendor,c.Category,sc.Subcategory,i.Item,
--U.Unit as PackingType
(Select Unit from unit  where UId=gd.PackageId) as PackingType,
gd.TotalPackage,gd.PcsPerPackage
,dsm.DSNo,
--iu.PkFactor as UnitQty
gm.Discount,ps.PONo,
Un.Unit as IssuanceType,iu.IssFactor,iu.PurFactor,
Uni.Unit as ReceipeType,iu.RecpFactor,UT.Unit as PurchaseUnit,iu.PkFactor,
i.ItemCode as UnitType,
ipl.ParLevel,
--isnull
--(
--(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='In' and w.ItemId=i.ItemId and w.SId=gm.SId and w.Date < @From)
---
--(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='Out' and w.ItemId=i.ItemId and w.SId=gm.SId and w.Date < @From)
--,0)as AvailableQty,
psd.Qty as OrderQty,
gd.Rate as UnitPrice,
gd.Qty as ReceivedQty from GRNMaster gm 
inner join GRNDetail gd on gm.GRNId=gd.GRNId
inner join Vendor v on v.VId=gm.VId
inner join PurchaseOrderMaster_Store ps on ps.POId=gd.POId
inner join PurchaseOrderDetail_Store psd on ps.POId=psd.POId
inner join DemandSheetMaster_Store dsm on dsm.DSCOId=psd.DSCOId
inner join Store s on gm.SId=s.SId
inner join Item i on gd.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
--inner join Unit U on iu.PkUnit=U.UId
inner join Unit Un on iu.IssUnit=Un.UId
inner join Unit Uni on iu.RecpUnit=Uni.UId
inner join Unit UT on iu.PurUnit=UT.UId
inner join Split(@DSNOId,',') sp on sp.items =dsm.DSCOId
where ipl.BRId=0 and ipl.SId>0 and psd.ItemId=gd.ItemId and gm.SId=@SId

group by gm.Date,gm.GRNo,v.Vendor,c.Category,sc.Subcategory,i.Item,
gd.PackageId,gd.TotalPackage,gd.PcsPerPackage
,dsm.DSNo,
gm.Discount,ps.PONo,v.Address,v.CellNo,
Un.Unit,iu.IssFactor,iu.PurFactor,
Uni.Unit,iu.RecpFactor,UT.Unit,iu.PkFactor,
i.ItemCode,psd.Qty ,gd.Qty,gd.Rate,
ipl.ParLevel
order by dsm.DSNo asc




















