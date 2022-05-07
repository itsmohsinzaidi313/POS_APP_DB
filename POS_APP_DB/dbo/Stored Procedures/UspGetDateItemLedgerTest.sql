
CREATE proc [dbo].[UspGetDateItemLedgerTest]--'07/17/14 12:00 AM','07/17/14 12:00 AM',0
@From as datetime,
@To as Datetime,
@Adj as int = null
as
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
(select isnull(sum(Qty),0) from WareHouse_Store where id = ws.Id and [Type] = 'In' and SId = @SId ) as [In],
(select isnull(sum(Qty),0) from WareHouse_Store where id = ws.Id and [Type] = 'Out' and SId = @SId ) as [Out],

(((select isnull(sum(Qty),0) from WareHouse_Store where  ItemId = i.ItemId and [Type] = 'In' and SId = @SId  and Date < @From and PDId = 0) -
(select isnull(sum(Qty),0) from WareHouse_Store where  ItemId =i.ItemId and [Type] = 'Out' and SId = @SId  and Date < @From and PDId = 0))
+
(select isnull(sum(Qty),0) from WareHouse_Store where id = ws.Id and [Type] = 'In' and SId = @SId  and ItemId = i.ItemId)
-
(select isnull(sum(Qty),0) from WareHouse_Store where id = ws.Id and [Type] = 'Out' and SId = @SId  and ItemId = i.ItemId)) as [Balance]
from Item i 
left join WareHouse_Store ws on i.ItemId = ws.ItemId
inner join SubCategory sb on sb.SBId = i.SBId
inner join Category cat on cat.CId = sb.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
--inner join Unit U on iu.PkUnit=U.UId
inner join Unit U on iu.PurUnit=U.UId
--where (ws.PDId = 0 and ws.Date between @From and @To and ws.InvAdjId > 0) or (ws.PDId = 0 and ws.Date between @From and @To and ws.InvAdjId = 0)
where 
--ws.PDId= 0 and 
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






