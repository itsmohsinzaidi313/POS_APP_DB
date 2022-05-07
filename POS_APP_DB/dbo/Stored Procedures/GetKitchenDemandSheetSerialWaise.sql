
CREATE Proc [dbo].[GetKitchenDemandSheetSerialWaise]--44
@BRId as int
as
Select db.DSId,CONVERT(VARCHAR(11),db.Date,106)Date,db.DSNo as [k.D.O No],b.Branch,d.department_name as Department,b.BRId,d.id,db.[Desc]
 from DemandSheetMaster_Branch db 
inner join Branch b on b.BRId = db.BRId
inner join DepartmentPos d on d.id = db.DId
where 
--BRId=@BRId 
-- and 
NOT EXISTS
(
select * from IssuanceMaster_Store where DSId = db.DSId
)
order by DSNo
