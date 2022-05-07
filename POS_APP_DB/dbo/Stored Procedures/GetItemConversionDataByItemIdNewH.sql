CREATE Proc [dbo].[GetItemConversionDataByItemIdNewH]--46
@ItemId as int
as
Select i.Item,ii.PurUnit,
(Select u.Unit from Unit u inner join ItemUnit iu on u.UID=iu.PurUnit where iu.ItemId = i.ItemId )as PurchasingUnit,
ii.IssUnit as InventoryUnitId,
(Select u.Unit from Unit u inner join ItemUnit iu on u.UID=iu.IssUnit where iu.ItemId = i.ItemId )as InventoryUnit,
--ii.RecpUnit as RecepieUnitId,
(Select u.Unit from Unit u inner join ItemUnit iu on u.UID=iu.RecpUnit where iu.ItemId = i.ItemId )as RecepiUnit,

(Select IssFactor from ItemUnit  where ItemId = i.ItemId )as IssuanceFactor,
(Select RecpFactor from ItemUnit  where ItemId = i.ItemId )as RecepFactor,
(ii.IssFactor/ii.RecpFactor)
--(ii.RecpFactor/ii.IssFactor) 
as ConversionToMultiple
from Item i 
inner join ItemUnit ii on i.ItemId=ii.ItemId
where i.ItemId=@ItemId
