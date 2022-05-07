CREATE proc [dbo].[uspGetAccountSummary]

@DateFrom as datetime,
@DateTo as datetime,
@CAId as nvarchar(max)

as

select ca.CAId,ca.AccNature as AccountType,(select AccName from ChartOfAccount where CAId = 
(select ParentId from ChartOfAccount where CAId = ca.ParentId)) as Check_Group,
(select AccName from ChartOfAccount where CAId = ca.ParentId) as SubGroup,
ca.AccName as Account,ca.AccNo as Account_No,
gl.VN as AccType,convert(varchar,gl.Date,110) as Date,Cast(gl.Amount as decimal(18,2)) as Amount,gl.[Type],
--gl.VoucherType as Description,
[dbo].funcGetVoucherDesc(gl.VN,gl.VoucherId,gl.CAId) as Description,
isnull([dbo].uspGetNetOpenBalanceFunc(ca.CAId,ca.COId,@DateFrom),0) as OpeningBalance,
Cast([dbo].funcAccSummaryCredit(0+gl.Amount,gl.[Type]) as decimal(18,2)) as Credit,
Cast([dbo].funcAccSummaryDebit(0+gl.Amount,gl.[Type]) as decimal(18,2)) as Debit,
Cast([dbo].funcAccSummaryBalance(
isnull([dbo].uspGetNetOpenBalanceFunc(ca.CAId,ca.COId,@DateFrom),0),
Cast([dbo].funcAccSummaryDebit(0+gl.Amount,gl.[Type]) as decimal(18,2)),
Cast([dbo].funcAccSummaryCredit(0+gl.Amount,gl.[Type]) as decimal(18,2)),ca.AccNature)
 as decimal(18,2)) as Balance,
ca.[Level],ca.ParentId,ca.COId,[dbo].funcGetChequeNo(gl.VN,gl.VoucherId,gl.CAId) as ChequeNum,
convert(varchar,@DateFrom,110) as DateFrom,
convert(varchar,@DateTo,110) as DateTo,'' as A,'' as B,'' as C,'' as D,'' as E,
Cast('0' as decimal(18,2)) as A1,
Cast('0' as decimal(18,2)) as A2,
Cast('0' as decimal(18,2)) as A3,
Cast('0' as decimal(18,2)) as A4,
Cast('0' as decimal(18,2)) as A5
from ChartOfAccount ca 
left join GL gl on ca.CAId = gl.CAId
inner join Split(@CAId,',') sp on sp.items = ca.CAId
where gl.Date between @DateFrom and @DateTo
order by ca.AccName,gl.Date,gl.VN


