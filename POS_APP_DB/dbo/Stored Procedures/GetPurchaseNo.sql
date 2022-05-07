CREATE proc [dbo].[GetPurchaseNo]

as
select pom.POId,pom.PONo,pom.Date,v.Vendor,v.VId from PurchaseOrderMaster_Store pom
inner join Vendor v on pom.VId = v.VId
where pom.Status=0 
order by pom.PONo
