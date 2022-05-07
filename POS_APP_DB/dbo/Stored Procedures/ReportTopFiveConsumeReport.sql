
Create Proc [dbo].[ReportTopFiveConsumeReport]--'7/1/2013 12:00:00 AM','9/30/2013 12:00:00 AM' ,'Admin'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max)
as
Declare @ReportName as nvarchar(max);
set @ReportName='Top Five Consumable Item';
select top (5) isnull(sum(pds.IngredientQty),0) as ConsumeQty,  CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To], 
@Login as LoginUser,c.Category,sc.Subcategory,i.Item,i.ItemId
--U.Unit as PackingType,
,@ReportName as ReportName,pds.PackingRatePerPcs,pds.InventoryRatePerPcs,pds.RecipeRatePerPcs,
iu.PkFactor as UnitQty,Cast(isnull(Round(avg(pds.IngredientAmount),2),0) AS DECIMAL (18,2))  as Rate,
--(Select Distinct(Unit) from unit  where UId=ids.Unit) as UnitType

--ipl.ParLevel
U.Unit as ReceipeUnit ,Un.Unit as IssuanceUnit
 from ProductSaleMaster psm 
inner join ProductSaleDetail pds on psm.PMID=pds.PMID
inner join Item i on pds.IngredientId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.RecpUnit=U.UId
inner join Unit Un on iu.IssUnit=Un.UId
where Date between @From and @To 
group by c.Category,sc.Subcategory,i.Item,i.ItemId,pds.PackingRatePerPcs,pds.InventoryRatePerPcs,pds.RecipeRatePerPcs,
U.Unit,pds.IngredientQty,
iu.PkFactor ,Un.Unit
--order by ids.Qty desc




















