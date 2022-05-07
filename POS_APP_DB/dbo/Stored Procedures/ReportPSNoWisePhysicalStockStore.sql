
CREATE Proc [dbo].[ReportPSNoWisePhysicalStockStore]--'6/26/2013 12:00:00 AM','6/27/2013 12:00:00 AM','Admin','28'
@Login as nvarchar(max),
@PSNoId as varchar(50),
@SId as int
as
select @Login as LoginUser,pm.Date,pm.PSNo,s.Store,c.Category,sc.Subcategory,i.Item,
U.Unit as PackingType,
iu.PurFactor as UnitQty,
(Select Distinct(Unit) from unit  where UId=ps.UId) as UnitType,
--(Select isnull(sum(Qty),0) from IssuanceDetail_Store id where  id.ItemId=i.ItemId)
isnull
(
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='In' and w.ItemId=i.ItemId and w.SId=pm.SId and w.Date<=pm.Date and w.SId = @SId)
-
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='Out' and w.ItemId=i.ItemId and w.SId=pm.SId and w.Date<=pm.Date and w.SId = @SId)
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
inner join Split(@PSNoId,',') sp on sp.items =pm.PSId
where s.SId = @SId
group by pm.Date,pm.PSNo,c.Category,sc.Subcategory,i.Item,U.Unit,iu.PurFactor 
,ps.UId,i.ItemId,pm.SId,ps.Amount,ps.Qty,s.Store
order by pm.date asc