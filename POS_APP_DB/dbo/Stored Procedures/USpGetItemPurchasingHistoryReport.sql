
CREATE Proc [dbo].[USpGetItemPurchasingHistoryReport]--39
@ItemId as int
as
select gm.Date,v.Vendor,im.InvoiceNo,gm.GRNo,c.Category,sc.Subcategory,i.Item,
pm.PONo,ds.DSNo,
(Select Distinct(Unit) from unit  where UId=gd.Unit) as UnitType,
gd.Qty as ReceivedQty,
gd.Rate as UnitPrice,gm.TotalAmount
 from GRNMaster gm 
inner join GRNDetail gd on gm.GRNId=gd.GRNId
inner join InvoiceMaster_Company im on im.GRNId=gd.GRNId
inner join PurchaseOrderMaster_Store pm on pm.POId=gd.POId
inner join PurchaseOrderDetail_Store pod on pm.POId=pod.POId
inner join DemandSheetMaster_Store ds on pod.DSCOId=ds.DSCOId
inner join Vendor v on v.VId=gm.VId
inner join Store s on gm.SId=s.SId
inner join Item i on gd.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
where i.ItemId=@ItemId
group by  gm.Date,v.Vendor,im.InvoiceNo,gm.GRNo,c.Category,sc.Subcategory,i.Item,
pm.PONo,ds.DSNo,gd.Qty,gd.Rate,gd.Unit,gm.TotalAmount
order by gm.Date desc





