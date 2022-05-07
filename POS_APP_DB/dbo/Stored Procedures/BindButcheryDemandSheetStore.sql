CREATE proc [dbo].[BindButcheryDemandSheetStore]
as

select dsb.DSId , dsb.DSNo,dsb.BRId,dsb.DId from DemandSheetMaster_Branch dsb
inner join DemandSheetDetail_Branch dsd
on  dsb.DSId=dsd.DSId
inner join Item i on dsd.ItemId=i.ItemId 
where i.[Type]='Non Butchery' 
and dsd.Status = 0
--and Not
--EXISTS
--(
--select * from DemandSheetDetail_Branch where DSId = dsb.DSId and Status = 0
----select * from DemandSheetDetail_Branch where DSId = 78 and Status = 0
--
--)
group by dsb.DSNo,dsb.DSId,dsb.BRId,dsb.DId