
create Proc [dbo].[GetProductionMasterDatadepartment]
as
Select pm.PRId,pm.Date,pm.PRNo as [P.R.NO],PM.Amount  as TotalAmount
from ProductionMasterdepartment pm 
inner join ProductionDetaildepartment pd on pm.PRId=pd.PRId
group by pm.PRId,pm.Date,pm.PRNo,PM.Amount



