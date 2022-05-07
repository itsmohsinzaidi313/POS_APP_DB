CREATE proc [dbo].[SummaryFoodCostBySerial]--'7/5/2013 12:00:00 AM','10/7/2013 12:00:00 AM'
@From as datetime,
@To as Datetime
as
select 
Isnull(sum(wh.Rate),0) as TotalIssue, wh.Date,
CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],
(select Isnull( sum(net_bill),0) from Order_Payment) as TotalSale,
--(select Isnull( sum(Rate),0) ) as TotalIssue,
(select Isnull(sum(qty),0) from Order_Detail) as TotalSaleQty,
(select i.Id from Order_Detail od
inner join ItemPOS i on i.item_name=od.item_name 
) as ProductId,
Cast(isnull('0',0) AS DECIMAL (18,2)) as TotalCost 

from WareHouse_Store wh
 where Type='Out'
and Date=wh.Date 
and IssId>0

group by wh.Date


--select Isnull(sum(wh.Rate),0) from WareHouse_Store wh where Type='Out'and IssId>0
