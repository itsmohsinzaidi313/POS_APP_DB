CREATE Proc [dbo].[InsertSubRecipe]
@RecipeId as int,
@SubRecipe as int,
@XML as xml
as
Declare @RecipeChk as int;
set @RecipeChk =0;
Declare @FinalChk as int;
set @FinalChk=0;
if @RecipeId >0
begin
Declare @Count as int;
set @Count =0;

Delete from SubRecipeDetail where SubRecipeId=@RecipeId;
Select @Count = count(id) from SubRecipeDetail where SubRecipeId=@RecipeId;
if @Count=0
begin
Delete from SubRecipeMaster where SubRecipeId=@RecipeId;
Select @RecipeChk= SubRecipeId from SubRecipeMaster where SubRecipeId=@RecipeId;
end
end
if @RecipeChk=0
begin 
Declare @NewRecipeId as int;
set @NewRecipeId = 0;
Declare @NewCount as int;
set @NewCount =0;
Insert Into SubRecipeMaster (ProductId) values(@SubRecipe) select @NewRecipeId=Scope_Identity();
if @NewRecipeId > 0
begin
declare @query2 as nvarchar(max);
Declare @ParamDef2 as  nvarchar(max);
SET @query2='Insert Into SubRecipeDetail (SubRecipeId,IngredientId,Qty) 
SELECT 
''' + CONVERT(VARCHAR(10),@NewRecipeId, 101) + ''',
myXML.value(''./@IngredientId'',''int''),
myXML.value(''./@Qty'', ''decimal (18,2)'')
FROM @XML.nodes(''/doc/title'') As nodes(myXML)'
Set @ParamDef2=N'@XML xml OUTPUT'
exec sp_executesql @query2,@ParamDef2,@XML=@XML OUTPUT
Declare @a as int;
set @a=0;
Select @a=count(id) from SubRecipeDetail d inner join SubRecipeMaster m on d.SubRecipeId=m.SubRecipeId where m.SubRecipeId=@NewRecipeId
set @FinalChk=@a
end
end

Select @FinalChk




