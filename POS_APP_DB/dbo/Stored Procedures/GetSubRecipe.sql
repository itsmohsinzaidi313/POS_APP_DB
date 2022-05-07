CREATE Proc [dbo].[GetSubRecipe]
as
Select SubRecipeMaster.SubRecipeId as RecipeId,Item.ItemId as ProductId, Item.Item as Product from SubRecipeMaster 
inner join Item on SubRecipeMaster.ProductId=Item.ItemId