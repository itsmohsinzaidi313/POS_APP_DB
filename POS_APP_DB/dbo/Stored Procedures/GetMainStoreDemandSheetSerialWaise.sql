
CREATE Proc [dbo].[GetMainStoreDemandSheetSerialWaise]
as
Select DS.DSCOId,CONVERT(VARCHAR(11),Date,106)Date,DS.DSNo as [D.O No],DS.[Desc]
from DemandSheetMaster_Store DS

 WHERE NOT EXISTS
(
select * from PurchaseOrderDetail_Store where DSCOId = DS.DSCOId
)


order by DSNo
