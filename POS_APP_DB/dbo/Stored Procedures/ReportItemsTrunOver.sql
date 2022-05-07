
CREATE Proc [dbo].[ReportItemsTrunOver]--'6/27/2013 12:00:00 AM','10/27/2013 12:00:00 AM','Admin'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max)
as
Declare @ReportName as nvarchar(max);
set @ReportName='Branch Issuance Item WISE';
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],@Login as LoginUser,@ReportName as store,c.Category,sc.Subcategory,i.Item,
(Select isnull(sum(Qty),0) from WareHouse_Store whs where InvoiceId > 0 and whs.ItemId=i.ItemId) as Purchasing,
(Select isnull(sum(Qty),0) from WareHouse_Store whs where IssId > 0 and whs.ItemId=i.ItemId) as Issuance
 
from WareHouse_Store whs 
inner join Item i on whs.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
where whs.Date between @From and @To and whs.PDId=0
group by c.Category,sc.Subcategory,i.Item,i.ItemId

















