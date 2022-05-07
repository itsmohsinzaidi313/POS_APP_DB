


CREATE Proc [dbo].[ReportItemVendorWiseReport]--'7/1/2013 12:00:00 AM','7/9/2013 12:00:00 AM','Admin','9'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max),
@ItemId as text
as
select  CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To], 
@Login as LoginUser,im.Date,v.Vendor,s.Store,c.Category,sc.Subcategory,i.Item,
U.Unit as PackingType,
iu.PkFactor as UnitQty,im.InvoiceNo,
(Select Distinct(Unit) from unit  where UId=idc.Unit) as UnitType,
--ipl.ParLevel,
(select ParLevel from ItemParLevel where ItemId= i.ItemId and SId = s.SId) as ParLevel,
--idc.Rate as UnitPrice,
--idc.Qty as PurchaseQty 
isnull([dbo].funcGetItemAvgRateInvoice(im.InvoiceId,i.ItemId,U.UId),0) as UnitPrice,
--isnull(sum(idc.Qty),0) as PurchaseQty 
idc.Qty as PurchaseQty 

from InvoiceMaster_CompanyNew im 
inner join InvoiceDetail_CompanyNew idc on im.InvoiceId=idc.InvoiceId
inner join Vendor v on v.VId=im.VId
inner join Store s on im.SId=s.SId
inner join Item i on idc.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
--inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Split(@ItemId,',') sp on sp.items = i.ItemId
where im.Date between @From and @To --and ipl.BRId=0 and ipl.SId>0
group by im.Date,v.Vendor,s.Store,c.Category,sc.Subcategory,i.Item,
U.Unit,iu.PkFactor,im.InvoiceNo,idc.Unit,
--ipl.ParLevel,
im.InvoiceId,i.ItemId,U.UId,idc.Qty,s.SId
order by im.date asc
