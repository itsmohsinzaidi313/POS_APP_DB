CREATE proc [dbo].[ItemTrunOverPurchaseConsumptionOne]--'08/01/13','9/30/13','45,46,48,49,50,51'
@From as datetime,
@To as Datetime,
@ItemId as text
as
SELECT  
C.Category,sc.SubCategory,i.Item,
CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],

    DATEPART(yyyy, imc.Date) as Year, 
    DATEPART(mm, imc.Date) as Month,

Isnull(sum(icd.NetAmount),0)as Purchased
FROM InvoiceMaster_Company imc
inner join InvoiceDetail_Company icd on imc.InvoiceId=icd.InvoiceId
inner join Item i on icd.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join Split(@ItemId,',') sp on sp.items = i.ItemId
where Date between @From and @To and icd.ItemId=i.ItemId
GROUP BY
    DATEPART(yyyy, imc.Date), 
    DATEPART(mm, imc.Date),
 C.Category,sc.SubCategory,i.Item,icd.ItemId
ORDER BY
    DATEPART(yyyy, imc.Date), DATEPART(mm, imc.Date)
