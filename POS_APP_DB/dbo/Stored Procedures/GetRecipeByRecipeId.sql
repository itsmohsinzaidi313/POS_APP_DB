CREATE Proc [dbo].[GetRecipeByRecipeId] 
@RecipeId as int
as
Select rd.IngredientId,i.Item as Ingredient,rd.Qty,
(Select u.Unit from Unit u inner join ItemUnit iu on u.UID=iu.RecpUnit where iu.ItemId = i.ItemId) as [Recipe Unit]
from RecipeMaster rm  inner join RecipeDetail rd on rm.RecipeId= rd.RecipeId  
inner join Item i on rd.IngredientId=i.ItemId 
where rm.RecipeId=@RecipeId
