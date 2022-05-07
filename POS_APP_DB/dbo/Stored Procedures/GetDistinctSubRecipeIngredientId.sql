
Create Proc [dbo].[GetDistinctSubRecipeIngredientId]
as
Select distinct (IngredientId) from SubRecipeDetail