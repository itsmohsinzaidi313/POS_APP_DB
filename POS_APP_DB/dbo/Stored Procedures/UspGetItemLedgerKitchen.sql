

CREATE proc [dbo].[UspGetItemLedgerKitchen]--'7/01/2013 12:00:00 AM','7/10/2013 12:00:00 AM','14','25'
@From as datetime,
@To as Datetime,
@ItemId as text,
@BRId as int,
@Adj as int = null
as
--Begin try
--Begin Transaction
--
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],cat.Category,sb.SubCategory,
i.ItemId,i.Item,
U.Unit as PackingType,
iu.RecpFactor as UnitQty,
(Select Distinct(Unit) from unit  where UId=iu.RecpUnit) as UnitType,ws.Date
--,ws.[Desc]
,[dbo].[GetInvoiceNoForItemledgerReportKitchen](ws.Id)as PINO,
((select isnull(sum(Qty),0) from WareHouse_Branch where  ItemId = i.ItemId and [Type] = 'In' and Date < @From and PDId = 0) -
(select isnull(sum(Qty),0) from WareHouse_Branch where  ItemId =i.ItemId and [Type] = 'Out' and Date < @From and PDId = 0)) as OpenBalance ,
 isnull(sum(ws.Qty),0) as Qty,
(select isnull(sum(Qty),0) from WareHouse_Branch where id = ws.Id and [Type] = 'In') as [In],
(select isnull(sum(Qty),0) from WareHouse_Branch where id = ws.Id and [Type] = 'Out') as [Out],
--0 as [Balance]

(((select isnull(sum(Qty),0) from WareHouse_Branch where  ItemId = i.ItemId and [Type] = 'In' and Date < @From and PDId = 0) -
(select isnull(sum(Qty),0) from WareHouse_Branch where  ItemId =i.ItemId and [Type] = 'Out' and Date < @From and PDId = 0))
+
(select isnull(sum(Qty),0) from WareHouse_Branch where id = ws.Id and [Type] = 'In' and ItemId = i.ItemId)
-
(select isnull(sum(Qty),0) from WareHouse_Branch where id = ws.Id and [Type] = 'Out' and ItemId = i.ItemId)) as [Balance],
br.Branch as [Type],
d.department_name as [Desc]
from Item i 
right join WareHouse_Branch ws on i.ItemId = ws.ItemId
inner join Split(@ItemId,',') sp on sp.items = i.ItemId 
inner join SubCategory sb on sb.SBId = i.SBId
inner join Category cat on cat.CId = sb.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.IssUnit=U.UId
inner join Branch br on ws.BRId = br.BRId
inner join DepartmentPos d on br.BRId = d.BRId

where 
--ws.PDId = 0 and 
ws.Date between @From and @To and ws.BRId = @BRId and ws.DId = d.id and (ws.InvAdjId = @Adj or @Adj is null)
group by i.ItemId,i.Item,ws.Date
--,ws.[Desc]
,ws.Id,cat.Category,sb.SubCategory,U.Unit,iu.RecpFactor,
ws.Unit,br.Branch,d.department_name,iu.RecpUnit
order by i.Item,ws.Date,ws.Id
--end try
--begin catch
--if @@Trancount > 0
--Rollback
--exec uspGetErrorInfo
--end catch





