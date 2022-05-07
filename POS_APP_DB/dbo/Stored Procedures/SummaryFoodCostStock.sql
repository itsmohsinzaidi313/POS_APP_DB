CREATE proc [dbo].[SummaryFoodCostStock]--'7/1/2013','8/31/2013'
@From as datetime,
@To as Datetime
as
select 
CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],
(
(Select isnull(sum(Qty),0) from WareHouse_Store w 
inner join Item i on w.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
where c.Category='Food' and w.[Type]='In' and w.Date between @From and @To
--group by Qty
)
-
(Select isnull(sum(Qty),0) from WareHouse_Store w  
inner join Item i on w.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
where c.Category='Food' and w.[Type]='Out' and w.Date between @From and @To
--group by Qty
)
)
as AvailableStockF,
(
(Select isnull(sum(Qty),0) from WareHouse_Store w
inner join Item i on w.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
where c.Category='Non Food' and w.[Type]='In' and w.Date between @From and @To
--group by Qty
)
-
(Select isnull(sum(Qty),0) from WareHouse_Store w  
inner join Item i on w.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
where c.Category='Non Food' and w.[Type]='Out' and w.Date between @From and @To
--group by Qty
)
)
as AvailableStockNF,

(select Isnull( sum(IngredientAmount),0) from ProductSaleDetail psd
inner join Item i on psd.IngredientId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ProductSaleMaster psm on psm.PMID=psd.PMID 
where c.Category='Food' and psm.Date between @From and @To
)
as ConsumptionAmountFood,
(select Isnull( sum(IngredientAmount),0) from ProductSaleDetail pd

inner join Item i on pd.IngredientId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ProductSaleMaster psm on psm.PMID=pd.PMID 
where c.Category='Non Food' and psm.Date between @From and @To
)
as ConsumptionAmountNonFood

--from ProductSaleMaster psm
--inner join ProductSaleDetail isd on psm.PMID=isd.PMID
--where psm.Date between @From and @To
--group by IngredientAmount


