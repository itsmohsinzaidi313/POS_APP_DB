CREATE Proc [dbo].[GetVendorDetailDataByMasterId] --'CASH',29
@Type as nvarchar(50),
@id as int
as

if @Type = 'CASH'
begin
--Select i.InvoiceId,i.InvoiceNo,
--cpd.Amount as PaidAmount,cpd.CAId,cpd.[Desc ]as Description
--from  CashPaymentMaster cpm  
--inner join CashPaymentDetail cpd on  cpm.CPId = cpd.CPId
----inner join SupplierLedger s on s.VoucherId = cpm.CPId
--inner join InvoiceMaster i on cpd.InvoiceId = i.InvoiceId
--where cpm.CPId = @id

Select i.InvoiceId,i.InvoiceNo,
((select isnull(sum(Amount),0) from SupplierLedger where VN = i.InvoiceNo and [Type] = 'C')- 
(select isnull(sum(TotalAmount),0) from PurchaseReturnMaster where InvoiceId = i.InvoiceId)) as TotalAmount,
(select isnull(sum(Amount),0) from SupplierLedger where InvoiceId = i.InvoiceId and [Type] = 'D' and VoucherId <> bpd.CPId
 and VoucherType like '% PAYMENT VOUCHER') as TotalPaid,
(((select isnull(sum(Amount),0) from SupplierLedger where VN = i.InvoiceNo and [Type] = 'C')- 
(select isnull(sum(TotalAmount),0) from PurchaseReturnMaster where InvoiceId = i.InvoiceId))-
(select isnull(sum(Amount),0) from SupplierLedger where InvoiceId = i.InvoiceId and [Type] = 'D' and VoucherId <> bpd.CPId and VoucherType like '% PAYMENT VOUCHER')) as Balance,
bpd.[Desc] as [Desc],
Cast(bpd.Amount as decimal(18,2)) as Amount,Cast('false' as bit) as [Select]
from InvoiceMaster_Company i
inner join CashPaymentDetail bpd on i.InvoiceId = bpd.InvoiceId
where bpd.CPId = @id

end
else if @Type = 'BANK'
begin

--Select i.InvoiceId,i.InvoiceNo,
--cpd.Amount as PaidAmount,cpd.CAId,cpd.[Desc ]as Description
--from  BankPaymentMaster cpm  
--inner join  BankPaymentDetail cpd on  cpm.BPId = cpd.BPId
--inner join InvoiceMaster i on cpd.InvoiceId = i.InvoiceId
--where cpm.BPId = @id

Select i.InvoiceId,i.InvoiceNo,
((select isnull(sum(Amount),0) from SupplierLedger where VN = i.InvoiceNo and [Type] = 'C')- 
(select isnull(sum(TotalAmount),0) from PurchaseReturnMaster where InvoiceId = i.InvoiceId)) as TotalAmount,
(select isnull(sum(Amount),0) from SupplierLedger where InvoiceId = i.InvoiceId and [Type] = 'D' and VoucherId <> bpd.BPId
 and VoucherType like '% PAYMENT VOUCHER') as TotalPaid,
(((select isnull(sum(Amount),0) from SupplierLedger where VN = i.InvoiceNo and [Type] = 'C')- 
(select isnull(sum(TotalAmount),0) from PurchaseReturnMaster where InvoiceId = i.InvoiceId))-
(select isnull(sum(Amount),0) from SupplierLedger where InvoiceId = i.InvoiceId and [Type] = 'D' and VoucherId <> bpd.BPId and VoucherType like '% PAYMENT VOUCHER')) as Balance,
bpd.[Desc] as [Desc],
Cast(bpd.Amount as decimal(18,2)) as Amount,Cast('false' as bit) as [Select]
from InvoiceMaster_Company i
inner join BankPaymentDetail bpd on i.InvoiceId = bpd.InvoiceId
where bpd.BPId = @id


end

