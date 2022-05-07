
CREATE Proc [dbo].[ReportItemWisePhysicalStockStore]--'6/26/2013 12:00:00 AM','6/27/2013 12:00:00 AM','Admin','28'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max),
@ItemId as text,
@SId as int
as
Declare @ReportName as nvarchar(max);
set @ReportName='Physical Stock Store Item wise';
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],@Login as LoginUser,pm.Date,pm.PSNo,@ReportName as store,c.Category,sc.Subcategory,i.Item,
U.Unit as PackingType,
iu.PurFactor as UnitQty,
(Select Distinct(Unit) from unit  where UId=ps.UId) as UnitType,
isnull
(
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='In' and w.ItemId=i.ItemId and w.SId=pm.SId)
-
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='Out' and w.ItemId=i.ItemId and w.SId=pm.SId)
,0)
as InventoryBalance,
ps.Amount as UnitRate,
ps.Qty as PhysicalQty from PhysicalStockMaster_Store pm 
inner join PhysicalStockDetail_Store ps on pm.PSId=ps.PSId
inner join Store s on pm.SId=s.SId
inner join Item i on ps.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Split(@ItemId,',') sp on sp.items = i.ItemId
where pm.Date between @From and @To and pm.SId=@SId
group by pm.Date,pm.PSNo,c.Category,sc.Subcategory,i.Item,U.Unit,iu.PurFactor 
,ps.UId,i.ItemId,pm.SId,ps.Amount,ps.Qty
order by pm.date asc
















