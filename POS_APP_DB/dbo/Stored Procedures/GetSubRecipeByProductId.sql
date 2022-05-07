CREATE Proc [dbo].[GetSubRecipeByProductId]--15
@ProductId as int
as
Select rd.IngredientId,i.Item as Ingredient,rd.Qty,
(Select u.Unit from Unit u inner join ItemUnit iu on u.UID=iu.RecpUnit where iu.ItemId = i.ItemId) as [Recipe Unit]
from SubRecipeMaster rm  inner join SubRecipeDetail rd on rm.SubRecipeId= rd.SubRecipeId  
inner join Item i on rd.IngredientId=i.ItemId 
where rm.ProductId=@ProductId
