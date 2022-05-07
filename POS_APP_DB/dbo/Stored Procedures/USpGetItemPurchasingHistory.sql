


CREATE Proc [dbo].[USpGetItemPurchasingHistory]--'6/27/2013 12:00:00 AM','6/27/2013 12:00:00 AM','Admin','10'
@From as datetime,
@To as Datetime,
@ItemId as int
as
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],

gm.Date,v.Vendor
--,im.InvoiceNo
,gm.GRNo,c.Category,sc.Subcategory,i.Item,

(Select Distinct(Unit) from unit  where UId=gd.Unit) as UnitType,
gd.Qty as ReceivedQty,
gd.Rate as UnitPrice,gd.Amount
 from GRNMaster gm 
inner join GRNDetail gd on gm.GRNId=gd.GRNId
--inner join InvoiceMaster_Company im on im.GRNId=gd.GRNId
inner join Vendor v on v.VId=gm.VId
inner join Store s on gm.SId=s.SId
inner join Item i on gd.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
where gm.Date between @From and @To and  i.ItemId=@ItemId
order by gm.Date desc