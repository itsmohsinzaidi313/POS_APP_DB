
Create Proc [dbo].[GetTransferMaster]
as
Select TransferId,Date,TRNo,[From],[To] from Transfer
