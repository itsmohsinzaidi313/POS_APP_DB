create  proc [dbo].[CostPriceOfProduct]
@ProductId as int,
@Date as datetime,
@BRID as int
as
select 
(isnull(sum(rd.Qty),0) *
Cast(isnull(Round((select isnull(avg(Rate),0) from Warehouse_Branch where 
ItemId=rd.IngredientId and 
Date =@Date and BRId = @BRID)/
(
(select isnull(RecpFactor,0) from ItemUnit 
where ItemId=rd.IngredientId
)),3),0) AS DECIMAL (18,3))) as Amount
from RecipeMaster rm
inner join RecipeDetail rd on rm.RecipeId = rd.RecipeId
inner join ItemUnit iu on iu.ItemId = rd.IngredientId
where 
rm.ProductId = @ProductId
group by rd.IngredientId