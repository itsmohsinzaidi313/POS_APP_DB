
--Select * from warehouse_branch


CREATE Proc [dbo].[ABC]--'2014-06-24 00:00:00.000','2014-06-24 00:00:00.000','chim Chim'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max)
as
Declare @ReportName as nvarchar(max);
set @ReportName='Top All Consumable Item';
Select 
CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To], 
@Login as LoginUser,c.Category,sc.Subcategory,i.Item,i.ItemId
,@ReportName as ReportName,
((Select isnull(sum(Qty),0) from warehouse_branch where ItemId = i.ItemId and [Desc] ='Sale' and [Type] = 'Out' and Date between @From and @To )
-
(Select isnull(sum(Qty),0) from warehouse_branch where ItemId = i.ItemId and [Desc] ='Sale' and [Type] = 'In' and Date between @From and @To )
)as ConsumeQty,





--pds.PackingRatePerPcs,pds.InventoryRatePerPcs,pds.RecipeRatePerPcs,
iu.PkFactor as PakageFactor,iu.PurFactor as PurchaseFactor,RecpFactor,
--Cast(isnull(Round(avg(pds.IngredientAmount),2),0) AS DECIMAL (18,2))  as Rate,
U.Unit as ReceipeUnit ,Un.Unit as IssuanceUnit
 from warehouse_branch w 
inner join Item i on w.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.RecpUnit=U.UId
inner join Unit Un on iu.IssUnit=Un.UId
where Date between @From and @To 
group by c.Category,sc.Subcategory,i.Item,i.ItemId,
--pds.PackingRatePerPcs,pds.InventoryRatePerPcs,pds.RecipeRatePerPcs,
U.Unit,
iu.PkFactor,iu.PurFactor,RecpFactor,
----pds.IngredientQty,
--iu.PkFactor ,
Un.Unit



--select * from ItemUnit



















