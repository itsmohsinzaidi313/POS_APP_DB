create Proc [dbo].[RptJournalVoucher]
@JVId as nvarchar(50)
as
Select 'JOURNAL VOUCHER' as ReportName,
m.VN,
m.Date,
d.Amount,
c.AccName as Account,
d.[Type],
d.[Desc],
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as Debit,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as Credit,
c.AccNo as STR1,
'' as STR2,'' as STR3,'' as STR4,'' as STR5,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as dec1,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as dec2,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as dec3,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as dec4,
Cast(isnull(Round('0',2),0) AS DECIMAL (18,2)) as dec5
from  JVMAster m
inner join JVDetail d on m.JVId = d.JVId 
inner join ChartOfaccount c on d.CAId = c.CAId
where  m.JVId = @JVId
