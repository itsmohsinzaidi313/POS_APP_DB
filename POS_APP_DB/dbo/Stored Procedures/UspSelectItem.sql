

CREATE proc [dbo].[UspSelectItem]
as
select Item.ItemId, SubCategory.CId, Category,SubCategory,Item.SBId,
--[group].[group],[group].GRId,
'0','0',
Company.COId,Company.Company,b.Id,ItemType,Item ,ItemCode
from Item
inner join SubCategory on
SubCategory.SBId=Item.SBId
inner join Category on
Category.CId=SubCategory.CId
--right join [group] on
--[group].GRId=Item.GRId
inner join Company on
--Company.COId=[group].COId
Company.COId=Category.COId
inner join Butchery b on
--Company.COId=[group].COId
--b.Id=Item.[Type]
b.ItemType=Item.[Type]

