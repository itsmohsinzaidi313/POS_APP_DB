CREATE Proc [dbo].[InsertRecipe]
@RecipeId as int,
@ProductId as int,
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

Delete from RecipeDetail where RecipeId=@RecipeId;
Select @Count = count(id) from RecipeDetail where RecipeId=@RecipeId;
if @Count=0
begin
Delete from RecipeMaster where RecipeId=@RecipeId;
Select @RecipeChk= RecipeId from RecipeMaster where RecipeId=@RecipeId;
end
end
if @RecipeChk=0
begin 
Declare @NewRecipeId as int;
set @NewRecipeId = 0;
Declare @NewCount as int;
set @NewCount =0;
Insert Into RecipeMaster (ProductId) values(@ProductId) select @NewRecipeId=Scope_Identity();
if @NewRecipeId > 0
begin
declare @query2 as nvarchar(max);
Declare @ParamDef2 as  nvarchar(max);
SET @query2='Insert Into RecipeDetail (RecipeId,IngredientId,Qty) 
SELECT 
''' + CONVERT(VARCHAR(10),@NewRecipeId, 101) + ''',
myXML.value(''./@IngredientId'',''int''),
myXML.value(''./@Qty'', ''decimal (18,2)'')
FROM @XML.nodes(''/doc/title'') As nodes(myXML)'
Set @ParamDef2=N'@XML xml OUTPUT'
exec sp_executesql @query2,@ParamDef2,@XML=@XML OUTPUT
Declare @a as int;
set @a=0;
Select @a=count(id) from RecipeDetail d inner join RecipeMaster m on d.RecipeId=m.RecipeId where m.RecipeId=@NewRecipeId
set @FinalChk=@a
end
end

Select @FinalChk


