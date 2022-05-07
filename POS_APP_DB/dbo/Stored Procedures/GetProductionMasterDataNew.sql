
CREATE Proc [dbo].[GetProductionMasterDataNew]
as
Select pm.PRId,pm.Date,pm.PRNo as [P.R.NO],PM.Amount  as TotalAmount
--, whb.BRId
from ProductionMaster pm 
inner join ProductionDetail pd on pm.PRId=pd.PRId
--inner join WareHouse_Branch whb on whb.PDId=pm.PRId

group by pm.PRId,pm.Date,pm.PRNo,PM.Amount
--, whb.BRId



