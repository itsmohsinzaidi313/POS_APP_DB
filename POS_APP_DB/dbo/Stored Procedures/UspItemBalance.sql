CREATE proc [dbo].[UspItemBalance]--'46'
@ItemId as int
as
select
isnull
(
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='In'and w.ItemId= @ItemId)
-
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='Out' and w.ItemId= @ItemId )
,0)
as AvailableQty
from WareHouse_Store gd
inner join Item i on i.ItemId=gd.ItemId
where gd.ItemId=@ItemId
group by i.ItemId



