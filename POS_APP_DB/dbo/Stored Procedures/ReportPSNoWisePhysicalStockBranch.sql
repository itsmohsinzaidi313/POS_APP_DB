
CREATE Proc [dbo].[ReportPSNoWisePhysicalStockBranch]--'6/26/2013 12:00:00 AM','6/26/2013 12:00:00 AM','Admin','28'

@Login as nvarchar(max),
@PSNoId as varchar(50)
as
select @Login as LoginUser,pm.Date,pm.PSNo,b.Branch,c.Category,sc.Subcategory,i.Item,
U.Unit as PackingType,
iu.PurFactor as UnitQty,
(Select Distinct(Unit) from unit  where UId=ps.UnitId) as UnitType,
--(Select isnull(sum(Qty),0) from IssuanceDetail_Store id where  id.ItemId=i.ItemId)
isnull
(
(Select isnull(sum(Qty),0) from WareHouse_Branch w where [Type]='In' and w.ItemId=i.ItemId and w.BRId=pm.BRId and w.DId = d.id)
-
(Select isnull(sum(Qty),0) from WareHouse_Branch w where [Type]='Out' and w.ItemId=i.ItemId and w.BRId=pm.BRId and w.DId = d.id)
,0)

as WareHouseQty,ps.Amount as UnitRate,
ps.Qty as PhysicalQty 
,
d.department_name as Department
from PhysicalStockMaster_Branch pm 
inner join PhysicalStockDetail_Branch ps on pm.PSBRId=ps.PSBRId
inner join Branch b on pm.BRId=b.BRId
inner join DepartmentPos d on b.BRId = d.BRId
inner join Item i on ps.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Split(@PSNoId,',') sp on sp.items = pm.PSBRId
where pm.DId = d.id
group by pm.Date,pm.PSNo,c.Category,sc.Subcategory,i.Item,U.Unit,
iu.PurFactor,UnitId,i.ItemId,ps.Qty,ps.Amount,b.Branch,pm.BRId,d.id,d.department_name
order by pm.PSNo asc
















