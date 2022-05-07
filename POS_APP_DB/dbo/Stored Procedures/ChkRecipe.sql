
Create Proc [dbo].[ChkRecipe]
@Type as nvarchar(50),
@ProductId as int
as
if @Type='Recipe'
begin
Select ProductId from RecipeMaster where ProductId=@ProductId
end
else if @Type='SubRecipe'
begin
Select ProductId from SubRecipeMaster where ProductId=@ProductId
end