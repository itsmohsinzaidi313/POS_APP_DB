create Proc [dbo].[getPaymentVouchers]
@Type as nvarchar(50)
as
if @Type = 'Bank'
begin
Select cpm.PVId,cpm.BPId,cpm.VN,pm.[Type] as [Payment Type],cpm.Date,cpm.TotalAmount,cpm.CAID,pm.SPId ,cpm.ChequeNo,cpm.ChequeDate 
from BankPaymentMaster cpm
inner join PaymentVoucher pm on cpm.PVId = pm.PVId order by cpm.VN
end
else if @Type ='Cash'
begin
Select cpm.PVId,cpm.CPId,cpm.VN,pm.[Type] as [Payment Type],cpm.Date,cpm.TotalAmount,cpm.CAID,pm.SPId  
from CashPaymentMaster cpm
inner join PaymentVoucher pm on cpm.PVId = pm.PVId order by cpm.VN
end