CREATE proc [dbo].[SummaryFoodCostSale]--'7/1/2013','8/31/2013'
@From as datetime,
@To as Datetime
as
select 
CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],
(select Isnull( sum(net_bill),0) from dbo.Order_Payment where cash_sale>0 and order_type = 'DINE IN')
as DCash,
(select Isnull( sum(net_bill),0) from dbo.Order_Payment where credit_sale>0 and order_type = 'DINE IN')
as DCredit,
(select Isnull( sum(net_bill),0) from dbo.Order_Payment where ent>0 and order_type = 'DINE IN') 
as DEntertainment,
(select Isnull( sum(net_bill),0) from dbo.Order_Payment where cash_sale>0 and order_type = 'TAKE AWAY')
as TCash,
(select Isnull( sum(net_bill),0) from dbo.Order_Payment where credit_sale>0 and order_type = 'TAKE AWAY')
as TCredit,
(select Isnull( sum(net_bill),0) from dbo.Order_Payment where ent>0 and order_type = 'TAKE AWAY' )
as TEntertainment,
(select Isnull( sum(net_bill),0) from dbo.Order_Payment where cash_sale>0 and order_type = 'DELIVERY')
as DLCash,
(select Isnull( sum(net_bill),0) from dbo.Order_Payment where credit_sale>0 and order_type = 'DELIVERY')
as DLCredit,
(select Isnull( sum(net_bill),0) from dbo.Order_Payment where ent>0 and order_type = 'DELIVERY' )
as DLEntertainment
from Order_Payment op
where op.Date between @From and @To
group by net_bill



