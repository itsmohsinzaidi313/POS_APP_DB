CREATE Proc [dbo].[GetItemConversionDataByItemIdNew]--14
@ItemId as int
as
Select i.Item,ii.PurUnit,
(Select u.Unit from Unit u inner join ItemUnit iu on u.UID=iu.PurUnit where iu.ItemId = i.ItemId )as PurchasingUnit,
ii.IssUnit as InventoryUnitId,
(Select u.Unit from Unit u inner join ItemUnit iu on u.UID=iu.IssUnit where iu.ItemId = i.ItemId )as InventoryUnit,
ii.RecpUnit as RecepieUnitId,
(Select u.Unit from Unit u inner join ItemUnit iu on u.UID=iu.RecpUnit where iu.ItemId = i.ItemId )as RecepiUnit,
((ii.PurFactor/ii.IssFactor )* (ii.IssFactor/ii.RecpFactor)) as ConversionToMultiple
from Item i 
inner join ItemUnit ii on i.ItemId=ii.ItemId
where i.ItemId=@ItemId
