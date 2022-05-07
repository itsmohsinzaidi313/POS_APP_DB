Create Proc [dbo].[DeleteRecipe]
@RecipeId as int
as
Declare @RecipeChk as int;
set @RecipeChk =0;
Declare @FinalChk as int;
set @FinalChk=0;
Delete from Recipedetail where RecipeId=@RecipeId
Select @RecipeChk =count(id) from Recipedetail where RecipeId=@RecipeId
if @RecipeChk=0
begin
Delete from RecipeMaster where RecipeId=@RecipeId
Select @FinalChk =RecipeId from RecipeMaster where RecipeId=@RecipeId
end
Select @FinalChk