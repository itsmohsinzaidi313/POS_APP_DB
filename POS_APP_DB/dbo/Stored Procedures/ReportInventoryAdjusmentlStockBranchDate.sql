
CREATE Proc [dbo].[ReportInventoryAdjusmentlStockBranchDate]--'admin','32'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max)
as
select 
CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],
@Login as LoginUser,idms.Date,idms.AdjNo,b.Branch, dp.department_name as 'Category',sc.Subcategory,i.Item,
U.Unit as PackingType,
iu.PurFactor as UnitQty,
(Select Distinct(Unit) from unit  where UId=iads.Unit) as UnitType,
--(Select isnull(sum(Qty),0) from IssuanceDetail_Store id where  id.ItemId=i.ItemId)
isnull
(
(Select isnull(sum(Qty),0) from WareHouse_Branch w where [Type]='In' and w.ItemId=i.ItemId and w.BRId=idms.BRId and InvAdjId=0 and w.Date<=idms.Date)
-
(Select isnull(sum(Qty),0) from WareHouse_Branch w where [Type]='Out' and w.ItemId=i.ItemId and w.BRId=idms.BRId and InvAdjId=0 and w.Date<=idms.Date)
,0)

as InventoryBalanceBeforeAdjustment,
isnull
(
(Select isnull(sum(Qty),0) from WareHouse_Branch w where [Type]='In' and w.ItemId=i.ItemId and w.BRId=idms.BRId )
-
(Select isnull(sum(Qty),0) from WareHouse_Branch w where [Type]='Out' and w.ItemId=i.ItemId and w.BRId=idms.BRId)
,0)

as InventoryBalanceAfterAdjustment,
--ps.Amount as UnitRate,
iads.Qty as AdjusmentQty,
iads.[Type] as AdjusmentType
from InvAdjMaster_Branch idms 
inner join InvAdjDetail_Branch iads on idms.AdjBRId=iads.AdjBRId
inner join Branch b on idms.BRId=b.BRId
inner join DepartmentPOS dp on idms.DId=dp.id
inner join Item i on iads.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.PkUnit=U.UId
--inner join Split(@AdjNoId,',') sp on sp.items =idms.AdjBRId
where idms.Date between @From and @To 
group by idms.Date,idms.AdjNo,c.Category,sc.Subcategory,i.Item,U.Unit,iu.PurFactor 
,iads.Unit,i.ItemId,idms.BRId,idms.BRId,iads.Qty,b.Branch,iads.[Type],dp.department_name
order by idms.Date asc



















