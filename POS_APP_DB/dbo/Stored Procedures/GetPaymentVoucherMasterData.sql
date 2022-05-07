CREATE Proc [dbo].[GetPaymentVoucherMasterData]
@Type as nvarchar(50)
as
if @Type = 'CASH'
begin
Select distinct cpm.CPId,cpm.VN as [Voucher No],cpm.Date,ca.AccName as [Account Head],cpd.[desc] from CashPaymentMaster cpm
inner join CashPaymentDetail cpd on cpd.cpid=cpm.cpid
inner join chartofaccount ca on ca.caid=cpd.caid

end
else if @Type = 'BANK'
begin

Select  distinct bpm.bPId,bpm.VN as [Voucher No],bpm.Date,ca.AccName as [Account Head],bpd.[desc] from BankPaymentMaster bpm
inner join BankPaymentDetail bpd on bpd.bpid=bpm.bpid
inner join chartofaccount ca on ca.caid=bpd.caid

end
