
CREATE proc [dbo].[uspGetVoucherDetailsByDate]
@DateFrom as datetime,
@DateTo as datetime,
@VoucherType as nvarchar(10)

as
Declare @Report nvarchar(MAX);
set @Report = '';

if @VoucherType = 'PV'
Begin
set @Report = 'PAYMENT VOUCHERS'
End
else if @VoucherType = 'BPV'
Begin
set @Report = 'BANK PAYMENT VOUCHERS'
End
else if @VoucherType = 'CPV'
Begin
set @Report = 'CASH PAYMENT VOUCHERS'
End
else if @VoucherType = 'BRV'
Begin
set @Report = 'BANK RECEIPT VOUCHERS'
End
else if @VoucherType = 'CRV'
Begin
set @Report = 'CASH RECEIPT VOUCHERS'
End
else if @VoucherType = 'JV'
Begin
set @Report = 'JOURNAL VOUCHERS'
End
else if @VoucherType = 'SAL'
Begin
set @Report = 'SALE VOUCHERS'
End
else if @VoucherType = 'INV'
Begin
set @Report = 'INVOICES'
End

select gl.VN,
gl.Date,
ca.AccNo,
ca.AccName,
gl.[Type],
[dbo].[funcGetVoucherDescForVoucherByDate](gl.VN,gl.VoucherId,gl.CAId) as Description,gl.Amount,
[dbo].funcGetChequeNo(gl.VN,gl.VoucherId,gl.CAId) as ChequeNum,
convert(varchar,@DateFrom,110) as DateFrom,
convert(varchar,@DateTo,110) as DateTo,@Report as A,'' as B,'' as C,'' as D,'' as E,
Cast('0' as decimal(18,2)) as A1,
Cast('0' as decimal(18,2)) as A2,
Cast('0' as decimal(18,2)) as A3,
Cast('0' as decimal(18,2)) as A4,
Cast('0' as decimal(18,2)) as A5

from GL gl
inner join ChartOfAccount ca 
on gl.CAId = ca.CAId
where gl.VN like @VoucherType+'%' and gl.date between @DateFrom and @DateTo
order by VN,gl.Date


