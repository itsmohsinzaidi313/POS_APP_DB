CREATE proc [dbo].[GetItem]--'SubRecipe','83'
@Type as nvarchar(50),
@Sid as int
as

if @Type='Recipe'
begin
select i.ItemId as IngredientID,
i.Item as Ingredient
from Item i
inner join SubCategory on SubCategory.SBId=i.SBId
inner join Category on Category.CId=SubCategory.CId
inner join Company on Company.COId=Category.COId
inner join ItemParLevel on ItemParLevel.ItemId=i.ItemId where ItemParLevel.BRID=0 and ItemParLevel.SId=@Sid
end
else if @Type='SubRecipe'
begin
select i.ItemId as IngredientID,
i.Item as Ingredient
from Item i
inner join SubCategory on SubCategory.SBId=i.SBId
inner join Category on Category.CId=SubCategory.CId
inner join Company on Company.COId=Category.COId
inner join ItemParLevel on ItemParLevel.ItemId=i.ItemId where ItemParLevel.BRID=0 and ItemParLevel.SId=@Sid
and  SubCategory.Subcategory not like 'Sub%'
end

