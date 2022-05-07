create Proc [dbo].[GetCustomerMasterData]
@Type as nvarchar(50)
as

if @Type = 'CASH'
begin

Select pv.RVId,cpm.CRId,cpm.VN,cpm.Date,cpm.TotalAmount,cpm.CAID,pv.CustId,
(select Customer from Customer where CustId = pv.CustId) as Customer

from CashReceiptMaster cpm 
inner join ReceiptVoucher pv on cpm.RVId = pv.RVId 
where pv.ReceiptMode = 'CASH'

end
else if @Type = 'BANK'
begin

Select pv.RVId,bpm.BRId,bpm.VN,bpm.Date,bpm.TotalAmount,bpm.CAID,bpm.ChequeNo,bpm.ChequeDate,pv.CustId 
from BankReceiptMaster bpm 
inner join ReceiptVoucher pv on bpm.RVId = pv.RVId 
where pv.ReceiptMode = 'BANK'

end






