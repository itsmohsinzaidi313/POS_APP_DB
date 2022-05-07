


CREATE Proc [dbo].[USpGetItemPurchasingHistoryOne]--'6/27/2013 12:00:00 AM','6/27/2013 12:00:00 AM','Admin','10'
@ItemId as int
as
select gm.Date,v.Vendor--,gm.InvoiceNo
,gm.GRNo
,c.Category,sc.Subcategory,i.Item,

(Select Distinct(Unit) from unit  where UId=gd.Unit) as UnitType,
gd.Qty as ReceivedQty,
gd.Rate as UnitPrice,gd.Amount
 from GRNMaster gm 
-- from InvoiceMaster_CompanyNew gm 

inner join GRNDetail gd on gm.GRNId=gd.GRNId
--inner join InvoiceDetail_CompanyNew gd on gm.InvoiceId=gd.InvoiceId

--inner join InvoiceMaster_Company im on im.GRNId=gd.GRNId
inner join Vendor v on v.VId=gm.VId
inner join Store s on gm.SId=s.SId
inner join Item i on gd.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
where i.ItemId=@ItemId
order by gm.Date desc
