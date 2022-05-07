

CREATE Proc [dbo].[InsertProductSale]
@Znum as nvarchar(50),
@Date as datetime,
@XML as xml
as
BEGIN TRY
   BEGIN TRANSACTION  
declare @PMID as int;
set @PMID=0;
Declare @Master as nvarchar(max);
Set @Master='ProductSaleMaster';
Declare @Detail as nvarchar(max)
Set @Detail ='ProductSaleDetail';
declare @SQLString1 as nvarchar(max);
Declare @ParamDefination1 as  nvarchar(max);
SET @SQLString1='Insert Into '+@Master+' (ZNumber,Date) 
values(''' + CONVERT(VARCHAR(10),@Znum, 101) + ''',''' + CONVERT(VARCHAR(10),@Date, 101) + ''')
 Select @PMID = Scope_Identity()'
Set @ParamDefination1=N'@PMID int OUTPUT'
exec sp_executesql @SQLString1,@ParamDefination1,@PMID=@PMID OUTPUT
  COMMIT
if @PMID>0
begin
declare @SQLString2 as nvarchar(max);
Declare @ParamDefination2 as  nvarchar(max);
SET @SQLString2='Insert Into '+@Detail+' (PMID,IngredientId,PackingRatePerPcs,InventoryRatePerPcs,RecipeRatePerPcs,IngredientQty,IngredientAmount) 
SELECT 
''' + CONVERT(VARCHAR(10),@PMID, 101) + ''',
myXML.value(''./@IngredientId'', ''decimal (18,2)''),
myXML.value(''./@PackingRatePerPcs'', ''decimal (18,2)''),
myXML.value(''./@InventoryRatePerPcs'', ''decimal (18,2)''),
myXML.value(''./@RecipeRatePerPcs'', ''decimal (18,2)''),
myXML.value(''./@IngredientQty'', ''decimal (18,2)''),
myXML.value(''./@IngredientAmount'', ''decimal (18,2)'')
FROM @XML.nodes(''/doc/title'') As nodes(myXML)'
Set @ParamDefination2=N'@XML xml OUTPUT'
exec sp_executesql @SQLString2,@ParamDefination2,@XML=@XML OUTPUT

--select pd.id,pd.PMID,pd.IngredientId,pd.PackingRatePerPcs,pd.InventoryRatePerPcs,pd.RecipeRatePerPcs,pd.IngredientQty,pd.IngredientAmount,d.id from ProductSaleDetail pd
--inner join ItemPos i on pd.IngredientId = i.id
--inner join CategoryPos c on i.category_name = c.category_name
--inner join DepartmentPos d on c.department = d.department_name
--where PMID=@PMID

select pd.id,pd.PMID,pd.IngredientId,pd.PackingRatePerPcs,pd.InventoryRatePerPcs,pd.RecipeRatePerPcs,pd.IngredientQty,pd.IngredientAmount from ProductSaleDetail pd
--inner join ItemPos i on pd.IngredientId = i.id
--inner join CategoryPos c on i.category_name = c.category_name
--inner join DepartmentPos d on c.department = d.department_name
where pd.PMID=@PMID

    SET NOCOUNT OFF;
end

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
exec uspGetErrorInfo
END CATCH
