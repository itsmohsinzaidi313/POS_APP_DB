
CREATE Proc [dbo].[ReportVendorWiseReceivingReportBranch]--'6/26/2013 12:00:00 AM','6/29/2013 12:00:00 AM','Admin','10'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max),
@VendorId as text
as
Declare @ReportName as nvarchar(max);
set @ReportName='GOODS RECEIVING BRANCH VENDOR WISE';
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To], 
 @Login as LoginUser,gm.Date,gm.GRNo,v.Vendor,@ReportName as store,c.Category,sc.Subcategory,i.Item,
U.Unit as PackingType,dsm.DSNo,
iu.PurFactor as UnitQty,  gm.Discount,ps.PONo,im.InvoiceNo,
(Select Distinct(Unit) from unit  where UId=gd.Unit) as UnitType,
ipl.ParLevel,
isnull
(
(Select isnull(sum(Qty),0) from WareHouse_Branch w where [Type]='In' and w.ItemId=i.ItemId and w.BRId=gm.BRId )
-
(Select isnull(sum(Qty),0) from WareHouse_Branch w where [Type]='Out' and w.ItemId=i.ItemId and w.BRId=gm.BRId )
,0)
as AvailableQty,
psd.Qty as OrderQty,
gd.RatePerPcs as UnitPrice,
gd.Qty as ReceivedQty from GRNMaster gm 
inner join GRNDetail gd on gm.GRNId=gd.GRNId
inner join InvoiceMaster_Company im on im.GRNId=gd.GRNId
inner join Vendor v on v.VId=gm.VId
inner join PurchaseOrderMaster_Store ps on ps.POId=gd.POId
inner join PurchaseOrderDetail_Store psd on ps.POId=psd.POId
inner join DemandSheetMaster_Store dsm on dsm.DSCOId=psd.DSCOId
inner join Branch b on gm.BRId=b.BRId
inner join Item i on gd.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Split(@VendorId,',') sp on sp.items = v.VId
where gm.Date between @From and @To and ipl.BRId>0 and ipl.SId=0 and psd.ItemId=gd.ItemId
order by v.Vendor asc
















