create Proc [dbo].[GetCustomerDetailDataByMasterId]
@Type as nvarchar(50),
@id as int
as
if @Type = 'CASH'
begin
--Select 
--cpd.Amount as ReceiveAmount,cpd.CAId,cpd.[Desc ]as Description
--from  CashReceiptMaster cpm  
--inner join CashReceiptDetail cpd on  cpm.CRId = cpd.CRId
--where cpm.CRId = @id 



select ivd.[Desc],ivd.Amount as Amount,
(select AccName from ChartOfAccount where CAId = ivd.CAId) as Account,
(select [Type] from GL where VN = i.VN and CAId = ivd.CAId) as [Type],
ivd.CAId,
(select AccNature from ChartOfAccount where CAId = ivd.CAId) as AccNature
from CashReceiptMaster i 
inner join CashReceiptDetail ivd on i.CRId = ivd.CRId
where i.CRId = @id 


end
else if @Type = 'BANK'
begin

--Select 
--cpd.Amount as PaidAmount,cpd.CAId,cpd.[Desc ]as Description
--from  BankReceiptMaster cpm  
--inner join  BankReceiptDetail cpd on  cpm.BRId = cpd.BRId
--where cpm.BRId = @id 


select ivd.[Desc],ivd.Amount as Amount,
(select AccName from ChartOfAccount where CAId = ivd.CAId) as Account,
(select [Type] from GL where VN = i.VN and CAId = ivd.CAId) as [Type],
ivd.CAId,
(select AccNature from ChartOfAccount where CAId = ivd.CAId) as AccNature
from BankReceiptMaster i 
inner join BankReceiptDetail ivd on i.BRId = ivd.BRId
where i.BRId = @id 

end



