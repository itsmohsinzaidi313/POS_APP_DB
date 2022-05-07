

CREATE Proc [dbo].[ReportItem]
as
select c.Category,sc.Subcategory,i.Item,
U.Unit as PackingType,iu.PkFactor,

(Select Distinct(Unit) from unit  where UId=un.UId) as UnitType,
iu.PurFactor as UnitQty,
Uni.Unit as IssuanceUnit,
iu.IssFactor,
Unn.Unit as RecipeType,
iu.RecpFactor
from item i
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Unit Un on iu.PurUnit=Un.UId
inner join Unit Uni on iu.IssUnit=Uni.UId
inner join Unit Unn on iu.RecpUnit=Unn.UId

order by c.Category,sc.Subcategory,i.Item













