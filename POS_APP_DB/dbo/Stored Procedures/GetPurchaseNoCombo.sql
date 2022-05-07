Create proc [dbo].[GetPurchaseNoCombo]

as
select pom.POId,pom.PONo from PurchaseOrderMaster_Store pom
order by pom.PONo

