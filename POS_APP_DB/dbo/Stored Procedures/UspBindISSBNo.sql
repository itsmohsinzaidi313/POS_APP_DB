CREATE proc [dbo].[UspBindISSBNo]
as
select ibm.BUTId ,ibm.ISSBNo from IssuanceButcheryMaster ibm 
where
not exists
(
select * from ButcheryReturnMaster where BUTId= ibm.BUTId
)


