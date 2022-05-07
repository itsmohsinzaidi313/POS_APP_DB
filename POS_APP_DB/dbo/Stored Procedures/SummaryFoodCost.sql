create proc [dbo].[SummaryFoodCost]
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
as DLEntertainment,
(
(Select isnull(sum(Qty),0) from WareHouse_Store w 
inner join Item i on w.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
where c.Category='Food' and w.[Type]='In'
)
-
(Select isnull(sum(Qty),0) from WareHouse_Store w  
inner join Item i on w.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
where c.Category='Food' and w.[Type]='Out'
)
)
as AvailableQty,
(
(Select isnull(sum(Qty),0) from WareHouse_Store w
inner join Item i on w.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
where c.Category='Non Food' and w.[Type]='In'
)
-
(Select isnull(sum(Qty),0) from WareHouse_Store w  
inner join Item i on w.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
where c.Category='Non Food' and w.[Type]='Out'
)
)
as AvailableQtyNF,
(select Isnull( sum(Rate),0) from InvoiceDetail_Company idc  

inner join Item i on idc.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
where c.Category='Food'
)
as CreditPurchaseFood,
(select Isnull( sum(Rate),0) from InvoiceDetail_Company ic  

inner join Item i on ic.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
where c.Category='Non Food'
)
as CreditPurchaseNonFood,
(select Isnull( sum(IngredientAmount),0) from ProductSaleDetail psd
inner join Item i on psd.IngredientId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId

where c.Category='Food'
)
as Food,
(select Isnull( sum(IngredientAmount),0) from ProductSaleDetail pd

inner join Item i on pd.IngredientId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
where c.Category='Non Food'
)
as NonFood
--where Date between @From and @To