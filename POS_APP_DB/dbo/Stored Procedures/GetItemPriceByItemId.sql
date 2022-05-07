Create proc [dbo].[GetItemPriceByItemId]
@ItemId as int
as

Select Sale_Price  from ItemPOS  where id=@ItemId