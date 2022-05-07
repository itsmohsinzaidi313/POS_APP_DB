CREATE Proc [dbo].[uspGetOutdoorReceiptVouchers]
@Type as nvarchar(50)
as
if @Type = 'Bank'
begin
Select cpm.RVId,cpm.BRId,cpm.VN,pm.[Type] as [Payment Type],cpm.Date,cpm.TotalAmount,cpm.CAID,pm.CustId ,cpm.ChequeNo,cpm.ChequeDate 
from BankReceiptMaster cpm
inner join ReceiptVoucher pm on cpm.RVId = pm.RVId 
where pm.[Type] = 'Outdoor Customer Receipt'
order by cpm.VN
end
else if @Type ='Cash'
begin
Select cpm.RVId,cpm.CRId,cpm.VN,pm.[Type] as [Payment Type],cpm.Date,cpm.TotalAmount,cpm.CAID,pm.CustId  
from CashReceiptMaster cpm
inner join ReceiptVoucher pm on cpm.RVId = pm.RVId 
where pm.[Type] = 'Outdoor Customer Receipt'
order by cpm.VN
end

