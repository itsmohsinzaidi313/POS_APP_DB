
CREATE proc [dbo].[GetButcheryDetailReturn]
@BUTRId as int
as
select isd.ItemId,i.Item,u.UId,u.Unit,
Cast(isnull(sum(isd.Qty),0) as decimal(18,2)) as Qty,
isd.WesQty as WesQty,
Cast(isnull(avg(isd.Rate),0) as decimal(18,2)) as Rate,
Cast(isnull(avg(isd.Amount),0) as decimal(18,2)) as Amount,
Cast((Round((select isnull(IssFactor,0) from ItemUnit where ItemId = i.ItemId)/
(select isnull(PurFactor,0) from ItemUnit where ItemId = i.ItemId),2)) AS DECIMAL (18,2)) as Factor,
iu.PurUnit as PurUnitId,isd.RawItemId,(select Item from Item where ItemId = isd.RawItemId) as RawItem
from ButcheryReturnDetail isd
inner join Item i on isd.ItemId = i.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on u.UId = isd.Unit
where isd.BUTRId = @BUTRId
group by isd.ItemId,i.Item,u.UId,u.Unit,i.ItemId,iu.PurUnit,isd.WesQty,isd.RawItemId