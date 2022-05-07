create Proc [dbo].[GetVendorDetailDataByMasterIdAdv] --'CASH',29
@Type as nvarchar(50),
@id as int
as

if @Type = 'CASH'
begin

Select i.InvoiceId,
--i.InvoiceNo,
'Advance' as InvoiceNo,
cpd.Amount as PaidAmount,cpd.CAId,ca.AccName as Account,cpd.[Desc ]as Description
from  CashPaymentMaster cpm  
inner join CashPaymentDetail cpd on  cpm.CPId = cpd.CPId
inner join ChartOfAccount ca on ca.CAId = cpd.CAId
left join InvoiceMaster_Company i on cpd.InvoiceId = i.InvoiceId
where cpm.CPId = @id

end
else if @Type = 'BANK'
begin

Select i.InvoiceId,
--i.InvoiceNo,
'Advance' as InvoiceNo,
cpd.Amount as PaidAmount,cpd.CAId,ca.AccName as Account,cpd.[Desc ]as Description
from  BankPaymentMaster cpm  
inner join  BankPaymentDetail cpd on  cpm.BPId = cpd.BPId
inner join ChartOfAccount ca on ca.CAId = cpd.CAId
left join InvoiceMaster_Company i on cpd.InvoiceId = i.InvoiceId
where cpm.BPId = @id

end



