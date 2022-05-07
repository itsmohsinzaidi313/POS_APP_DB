Create Proc [dbo].[ReportRecipe]
@ProductId as int
as 
Select ip.item_name as Product,
ip.Sale_Price as SalePrice,
i.ItemId as IngredientId,
i.Item as Ingredient,
rd.Qty,
u.Unit as RecipeUnit,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as Amount 
From RecipeMaster rm  
inner join RecipeDetail rd on rm.RecipeId=rd.RecipeId
 inner join ItemPOS ip on rm.ProductId=ip.id 
inner join Item i on rd.IngredientId=i.ItemId 
inner join ItemUnit iu on i.ItemId=iu.ItemId   
inner join Unit u on iu.RecpUnit=u.UId
where rm.ProductId=@ProductId order by i.Item