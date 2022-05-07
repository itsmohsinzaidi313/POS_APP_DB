CREATE proc [dbo].[BindButcheryDemandSheet]
as
select dsb.DSId , dsb.DSNo from DemandSheetMaster_Branch dsb
inner join DemandSheetDetail_Branch dsd
on  dsb.DSId=dsd.DSId
inner join Item i on dsd.ItemId=i.ItemId 
inner join Butchery bu on bu.Id=i.[Type] 
where bu.ItemType='Butchery' and 
NOT EXISTS
(
select * from IssuanceMaster_Store where DSId = dsb.DSId
)
group by dsb.DSNo,dsb.DSId
