create Proc [dbo].[DeleteSubRecipe]
@RecipeId as int
as
Declare @RecipeChk as int;
set @RecipeChk =0;
Declare @FinalChk as int;
set @FinalChk=0;
Delete from SubRecipedetail where SubRecipeId=@RecipeId
Select @RecipeChk =count(id) from SubRecipedetail where SubRecipeId=@RecipeId
if @RecipeChk=0
begin
Delete from SubRecipeMaster where SubRecipeId=@RecipeId
Select @FinalChk =SubRecipeId from SubRecipeMaster where SubRecipeId=@RecipeId
end
Select @FinalChk
