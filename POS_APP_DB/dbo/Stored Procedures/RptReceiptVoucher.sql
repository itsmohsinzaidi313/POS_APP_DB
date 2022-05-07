create Proc [dbo].[RptReceiptVoucher]--'BANK',12
@Type as nvarchar(50),
@id as int
as




if @Type = 'CASH'
begin

Select 'CASH RECEIPT VOUCHER' as ReportType,m.VN,m.Date,m.TotalAmount,c.AccNo as ReceivedFromAccountNo,c.AccName as ReceivedFromAccountName
,d.Amount,cc.AccNo as PaidToAccountNo,cc.AccName as PaidToAccountName,'0' as AmountInWords,d.[desc],
'' as STR1,'' as STR2,'' as STR3,'' as STR4,'' as STR5,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as dec1,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as dec2,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as dec3,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as dec4,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as dec5
from CashReceiptMaster m 
inner join ChartOfaccount c on m.CAId = c.CAId
inner join CashReceiptDetail d on m.CRId =d.CRId
inner join ChartOfaccount cc on d.CAId = cc.CAId
where m.CRId = @id
and d.CAId <> m.CAId
end
else if @Type = 'BANK'
begin
Select 'BANK RECEIPT VOUCHER' as ReportType,m.VN,m.Date,m.TotalAmount,ChequeNo,ChequeDate,c.AccNo as ReceivedFromAccountNo,c.AccName as ReceivedFromAccountName
,d.Amount,cc.AccNo as PaidToAccountNo,cc.AccName as PaidToAccountName,'0' as AmountInWords,d.[desc],
'' as STR1,'' as STR2,'' as STR3,'' as STR4,'' as STR5,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as dec1,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as dec2,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as dec3,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as dec4,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as dec5
 from BankReceiptMaster m 
inner join ChartOfaccount c on m.CAId = c.CAId
inner join BankReceiptDetail d on m.BRId =d.BRId
inner join ChartOfaccount cc on d.CAId = cc.CAId
where m.BRId = @id
and d.CAId <> m.CAId
end

