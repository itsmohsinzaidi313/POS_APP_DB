CREATE Proc [dbo].[GetProductionMasterData]
as
Select pm.PRId,pm.Date,pm.PRNo as [P.R.NO],PM.Amount  as TotalAmount from ProductionMaster pm inner join ProductionDetail pd on pm.PRId=pd.PRId

