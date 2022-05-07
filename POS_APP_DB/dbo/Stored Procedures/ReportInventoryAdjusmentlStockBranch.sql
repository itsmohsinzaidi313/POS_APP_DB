
CREATE Proc [dbo].[ReportInventoryAdjusmentlStockBranch]--'admin','32'
@Login as nvarchar(max),
@AdjNoId as varchar(50)
as
select @Login as LoginUser,idms.Date,idms.AdjNo,b.Branch,c.Category,sc.Subcategory,i.Item,
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
inner join Item i on iads.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Split(@AdjNoId,',') sp on sp.items =idms.AdjBRId
--where pm.PSNo=@PSNoId
group by idms.Date,idms.AdjNo,c.Category,sc.Subcategory,i.Item,U.Unit,iu.PurFactor 
,iads.Unit,i.ItemId,idms.BRId,idms.BRId,iads.Qty,b.Branch,iads.[Type]
order by idms.Date asc
















