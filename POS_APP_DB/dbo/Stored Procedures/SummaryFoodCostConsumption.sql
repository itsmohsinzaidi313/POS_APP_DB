CREATE proc [dbo].[SummaryFoodCostConsumption]--'7/1/2013','8/31/2013'
@From as datetime,
@To as Datetime
as
select 
CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],

(select Isnull( sum(IngredientAmount),0) from ProductSaleDetail psd
inner join Item i on psd.IngredientId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId

where c.Category='Food'
)
as CAmountFood,
(select Isnull( sum(IngredientAmount),0) from ProductSaleDetail pd

inner join Item i on pd.IngredientId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
where c.Category='Non Food'
)
as CAmountNonFood
from ProductSaleMaster psm
inner join ProductSaleDetail isd on psm.PMID=isd.PMID
where psm.Date between @From and @To
group by IngredientAmount

