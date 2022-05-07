CREATE Proc [dbo].[GetReceiptVoucherMasterData]
@Type as nvarchar(50)
as
if @Type = 'CASH'
begin
Select distinct cpm.CRId,cpm.VN as [Voucher No],cpm.Date,cpd.[desc] from CashReceiptMaster cpm
left join CashReceiptDetail cpd on cpd.CRId=cpm.CRId
left join chartofaccount ca on ca.caid=cpd.caid

end
else if @Type = 'BANK'
begin
Select distinct cpm.BRId,cpm.VN as [Voucher No],cpm.Date,cpd.[desc] from BankReceiptMaster cpm
inner join BankReceiptdetail cpd on cpd.BRId=cpm.BRId
inner join chartofaccount ca on ca.caid=cpd.caid

end
