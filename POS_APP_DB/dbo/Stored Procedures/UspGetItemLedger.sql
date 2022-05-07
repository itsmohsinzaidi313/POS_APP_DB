
CREATE proc [dbo].[UspGetItemLedger]--'7/01/2013 12:00:00 AM','7/10/2013 12:00:00 AM','14'
@From as datetime,
@To as Datetime,
@ItemId as text
as
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],
i.ItemId,i.Item,ws.Date,
--ws.VoucherType,[dbo].[GetInvoiceNoForSupplyledgerReport](sl.VoucherId,sl.VoucherType)as PINO,
((select isnull(sum(Qty),0) from WareHouse_Store where  ItemId = i.ItemId and [Type] = 'In' and Date < @From) -
(select isnull(sum(Qty),0) from WareHouse_Store where  ItemId =i.ItemId and [Type] = 'Out' and Date < @From)) as OpenBalance ,
 
(select isnull(sum(Qty),0) from WareHouse_Store where Date = ws.Date and ItemId = i.ItemId and [Type] = 'In') as Debit,

(select isnull(sum(Qty),0) from WareHouse_Store where Date = ws.Date and ItemId = i.ItemId and [Type] = 'Out') as Credit,

(((select isnull(sum(Qty),0) from WareHouse_Store where ItemId = i.ItemId and [Type] = 'In' and Date < @From) -
(select isnull(sum(Qty),0) from WareHouse_Store where ItemId = i.ItemId and [Type] = 'Out' and Date < @From)) +
 
(select isnull(sum(Qty),0) from WareHouse_Store where Date = ws.Date and ItemId = i.ItemId and [Type] = 'In') -

(select isnull(sum(Qty),0) from WareHouse_Store where Date = ws.Date and ItemId = i.ItemId and [Type] = 'Out')) as Balance
--,ws.id
,ws.[Type]
--,ws.InvoiceId
from Item i 
inner join WareHouse_Store ws on i.ItemId = ws.ItemId
inner join Split(@ItemId,',') sp on sp.items = i.ItemId
order by 
--ws.Date,
ws.Id
