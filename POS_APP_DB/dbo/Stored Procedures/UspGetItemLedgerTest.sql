
CREATE proc [dbo].[UspGetItemLedgerTest]--'7/01/2013 12:00:00 AM','9/10/2013 12:00:00 AM','45'
@From as datetime,
@To as Datetime,
@ItemId as text,
@Adj as int = null

as
--Begin try
--Begin Transaction
--
Declare @SId as int
set @SId = 0;
select @SId = SId from Store where CentarlStore = 1;

select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],cat.Category,i.ItemCode as SubCategory,
i.ItemId,i.Item,U.Unit as PackingType,
iu.IssFactor as UnitQty,
--(Select Distinct(Unit) from unit  where UId=ws.Unit) as UnitType,
(select Unit from Unit where UId = iu.IssUnit) as UnitType,

ws.Date,
ws.[Desc],[dbo].[GetInvoiceNoForItemledgerReport](ws.Id)as PINO,
((select isnull(sum(Qty),0) from WareHouse_Store where  ItemId = i.ItemId and SId = @SId and [Type] = 'In' and Date < @From and PDId = 0) -
(select isnull(sum(Qty),0) from WareHouse_Store where  ItemId =i.ItemId and SId = @SId and [Type] = 'Out' and Date < @From and PDId = 0)) as OpenBalance ,
 isnull(sum(ws.Qty),0) as Qty,ws.[Type],
(select isnull(sum(Qty),0) from WareHouse_Store where id = ws.Id and SId = @SId and [Type] = 'In') as [In],
(select isnull(sum(Qty),0) from WareHouse_Store where id = ws.Id and SId = @SId and [Type] = 'Out') as [Out],
--0 as [Balance]

(((select isnull(sum(Qty),0) from WareHouse_Store where  ItemId = i.ItemId and SId = @SId and [Type] = 'In' and Date < @From and PDId = 0) -
(select isnull(sum(Qty),0) from WareHouse_Store where  ItemId =i.ItemId and SId = @SId and [Type] = 'Out' and Date < @From and PDId = 0))
+
(select isnull(sum(Qty),0) from WareHouse_Store where id = ws.Id and SId = @SId and [Type] = 'In' and ItemId = i.ItemId)
-
(select isnull(sum(Qty),0) from WareHouse_Store where id = ws.Id and SId = @SId and [Type] = 'Out' and ItemId = i.ItemId)) as [Balance]
from Item i 
right join WareHouse_Store ws on i.ItemId = ws.ItemId
inner join Split(@ItemId,',') sp on sp.items = i.ItemId 
inner join SubCategory sb on sb.SBId = i.SBId
inner join Category cat on cat.CId = sb.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.PurUnit=U.UId
where 
--ws.PDId = 0 and 
ws.Date between @From and @To and ws.SId = @SId and (ws.InvAdjId = @Adj OR @Adj is null)
group by i.ItemId,i.Item,ws.Date,ws.[Type],ws.[Desc],ws.Id,cat.Category,sb.SubCategory,U.Unit,iu.IssFactor,
ws.Unit,iu.IssUnit,i.ItemCode
order by i.Item,ws.Date,ws.Id
--end try
--begin catch
--if @@Trancount > 0
--Rollback
--exec uspGetErrorInfo
--end catch







