CREATE Proc [dbo].[GetRecipe]
as
Select r.RecipeId,r.ProductId,i.Item_Name as Product from RecipeMaster r inner join ItemPOS i on r.ProductId=i.id
where i.Item_Name <> 'Any'
