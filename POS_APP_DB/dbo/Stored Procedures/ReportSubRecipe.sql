Create Proc [dbo].[ReportSubRecipe]
@ProductId as int
as 
Select 
(Select ii.Item from SubRecipeMaster m inner join  Item ii on m.ProductId=ii.ItemId where m.ProductId=@ProductId)
as Product,
i.ItemId as IngredientId,
i.Item as Ingredient,
rd.Qty,
u.Unit as RecipeUnit,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as Amount 
From SubRecipeMaster rm  
inner join SubRecipeDetail rd on rm.SubRecipeId=rd.SubRecipeId
inner join Item i on rd.IngredientId=i.ItemId 
inner join ItemUnit iu on i.ItemId=iu.ItemId   
inner join Unit u on iu.RecpUnit=u.UId
where rm.ProductId=@ProductId order by i.Item
