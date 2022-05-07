CREATE proc [dbo].[SummaryFoodCostPurchased]
@From as datetime,
@To as Datetime
as
select 
CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],

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
as CreditPurchaseNonFood

from InvoiceMaster_Company imc

inner join InvoiceDetail_Company idc on imc.InvoiceId=idc.InvoiceId

where imc.Date between @From and @To

group by Rate
