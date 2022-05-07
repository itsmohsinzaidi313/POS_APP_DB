
CREATE Proc [dbo].[ReportInventoryAdjusmentlStockStoreDate]--'admin','32'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max)
as
select
CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],
 @Login as LoginUser,idms.Date,idms.AdjNo,s.Store,c.Category,sc.Subcategory,i.Item,
U.Unit as PackingType,
iu.PurFactor as UnitQty,
(Select Distinct(Unit) from unit  where UId=iads.Unit) as UnitType,
--(Select isnull(sum(Qty),0) from IssuanceDetail_Store id where  id.ItemId=i.ItemId)
isnull
(
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='In' and w.ItemId=i.ItemId and w.SId=idms.SId and InvAdjId=0 and w.Date<=idms.Date)
-
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='Out' and w.ItemId=i.ItemId and w.SId=idms.SId and InvAdjId=0 and w.Date<=idms.Date)
,0)

as InventoryBalanceBeforeAdjustment,
isnull
(
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='In' and w.ItemId=i.ItemId and w.SId=idms.SId )
-
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='Out' and w.ItemId=i.ItemId and w.SId=idms.SId)
,0)

as InventoryBalanceAfterAdjustment,
--ps.Amount as UnitRate,
iads.Qty as AdjusmentQty,
iads.[Type] as AdjusmentType
from InvAdjMaster_Store idms 
inner join InvAdjDetail_Store iads on idms.AdjId=iads.AdjId
inner join Store s on idms.SId=s.SId
inner join Item i on iads.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.PkUnit=U.UId
--inner join Split(@AdjNoId,',') sp on sp.items =idms.AdjId
where idms.Date between @From and @To 
group by idms.Date,idms.AdjNo,c.Category,sc.Subcategory,i.Item,U.Unit,iu.PurFactor 
,iads.Unit,i.ItemId,idms.SId,idms.SId,iads.Qty,s.Store,iads.[Type]
order by idms.Date asc

















