



CREATE proc [dbo].[UspGetabc]--'06/24/14 12:00 AM','06/24/14 12:00 AM','51'
@From as datetime,
@To as Datetime,
@BRId as int
as
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],cat.Category,sb.SubCategory,
i.ItemId,i.Item,U.Unit as PackingType,
iu.RecpFactor as UnitQty,
(Select Distinct(Unit) from unit  where UId=iu.RecpUnit) as UnitType,ws.Date
,''as PINO,
0 as OpenBalance ,

((select isnull(sum(Qty),0) from WareHouse_Branch where Itemid = i.Itemid and [Type] = 'In' and [Desc]  = 'Sale' and PMID > 0 and Date between @From and @To) -  (select isnull(sum(Qty),0) from WareHouse_Branch where Itemid = i.Itemid and [Type] = 'Out' and [Desc]  = 'Sale' and Date between @From and @To  and PMID > 0 ) )Qty,
0 as [In],
0 as [Out],
'0' as [Balance],
'' as [Type],'' as [Desc]
from Item i 
inner join WareHouse_Branch ws on i.ItemId = ws.ItemId
inner join SubCategory sb on sb.SBId = i.SBId
inner join Category cat on cat.CId = sb.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.IssUnit=U.UId
where 
ws.Date between @From and @To and ws.BRId = @BRId and ws.[Desc]  = 'Sale'  and PMID > 0 
group by i.ItemId,i.Item,ws.Date
,ws.Id,cat.Category,sb.SubCategory,U.Unit,iu.RecpFactor
,iu.RecpUnit
order by i.Item,ws.Date,ws.Id



