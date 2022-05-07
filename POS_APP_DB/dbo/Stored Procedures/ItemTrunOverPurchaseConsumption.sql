CREATE proc [dbo].[ItemTrunOverPurchaseConsumption]--'09/01/13','9/30/13','45,46,48,49,50,51'
@From as datetime,
@To as Datetime,
@ItemId as text
as
SELECT  
C.Category,sc.SubCategory,
i.Item,
CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],

    DATEPART(yyyy, psm.Date) as Year, 
    DATEPART(mm, psm.Date) as Month,
 Isnull(sum(psd.IngredientAmount),0)

 as Consumption

 from ProductSaleDetail psd 
inner join ProductSaleMaster psm on psm.PMID=psd.PMID
inner join Item i on psd.IngredientId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join Split(@ItemId,',') sp on sp.items = i.ItemId
where psm.Date between @From and @To and psd.IngredientId=i.ItemId
GROUP BY
    DATEPART(yyyy, psm.Date), 
    DATEPART(mm, psm.Date),
 C.Category,sc.SubCategory,
i.Item
--,icd.ItemId
ORDER BY
    DATEPART(yyyy, psm.Date), DATEPART(mm, psm.Date)