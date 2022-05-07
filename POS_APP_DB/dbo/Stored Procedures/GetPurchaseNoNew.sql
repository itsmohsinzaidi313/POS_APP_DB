
CREATE proc [dbo].[GetPurchaseNoNew]

as
select pom.POId,pom.PONo,pom.Date,v.Vendor,v.VId,pom.[Desc] from PurchaseOrderMaster_Store pom
inner join Vendor v on pom.VId = v.VId
where pom.Status=0 

 and NOT EXISTS
(
select * from GRNDetail where POId =  pom.POId
)

order by pom.PONo


