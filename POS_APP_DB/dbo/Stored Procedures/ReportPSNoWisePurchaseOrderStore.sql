



CREATE Proc [dbo].[ReportPSNoWisePurchaseOrderStore]--'78','13,','','142'
@COId as int,
@PONoId as text,
@Login as nvarchar(max),
@SId as int
as
select @Login as LoginUser,pm.Date,
pm.PONo as Category,
v.Vendor,s.Store,
c.Category as PONo,
--sc.Subcategory,
i.Item,
U.Unit as PackingType,
iu.PurFactor as UnitQty,Un.Unit as IssuanceType,iu.IssFactor,
Uni.Unit as ReceipeType,iu.RecpFactor,UT.Unit as PurchaseUnit,iu.PkFactor, ds.DSNo,
i.ItemCode as UnitType,v.Address,v.CellNo,
--ipl.ParLevel,
(select ParLevel from ItemParLevel where ItemId= i.ItemId and SId = pm.SId) as ParLevel,
ps.Rate as UnitPrice,
ps.Qty as OrderQty,pm.[Desc] as Subcategory from PurchaseOrderMaster_Store pm 
inner join PurchaseOrderDetail_Store ps on pm.POId=ps.POId
inner join Vendor v on pm.VId=v.VId
left join DemandSheetMaster_Store ds on ps.DSCOId=ds.DSCOId
inner join Store s on pm.SId=s.SId
inner join Item i on ps.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
--inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Unit Un on iu.IssUnit=Un.UId
inner join Unit Uni on iu.RecpUnit=Uni.UId
inner join Unit UT on iu.PurUnit=UT.UId
inner join Split(@PONoId,',') sp on sp.items = pm.POId
where pm.COId=@COId 
--and ipl.BRId=0 and ipl.SId>0 
and pm.SId=@SId
group by pm.Date,pm.PONo,v.Vendor,s.Store,c.Category,
--sc.Subcategory,
i.Item,
U.Unit,iu.PurFactor,Un.Unit,iu.IssFactor,Uni.Unit ,iu.RecpFactor,UT.Unit,
iu.PkFactor, ds.DSNo,
--ipl.ParLevel,
ps.Rate,ps.Qty ,
i.ItemCode,v.Address,v.CellNo,pm.SId,i.ItemId,pm.[Desc]
order by pm.PONo asc

