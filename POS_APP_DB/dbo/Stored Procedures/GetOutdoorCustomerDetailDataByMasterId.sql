
create Proc [dbo].[GetOutdoorCustomerDetailDataByMasterId] --'CASH',29
@Type as nvarchar(50),
@id as int
as

if @Type = 'CASH'
begin
Select i.id as InvoiceId,i.OrderNo as InvoiceNo,
((select isnull(sum(Amount),0) from CustomerLedger where VN = i.OrderNo and [Type] = 'C')- 
--(select isnull(sum(TotalAmount),0) from PurchaseReturnMaster where InvoiceId = i.InvoiceId)
0) as TotalAmount,

(select isnull(sum(Amount),0) from CustomerLedger where SaleId = i.id and [Type] = 'D' and VoucherId <> bpd.CRId
 and VoucherType like '% RECEIPT VOUCHER') as TotalPaid,
(((select isnull(sum(Amount),0) from CustomerLedger where VN = i.OrderNo and [Type] = 'C')- 
--(select isnull(sum(TotalAmount),0) from PurchaseReturnMaster where InvoiceId = i.InvoiceId)
0)-
(select isnull(sum(Amount),0) from CustomerLedger where SaleId = i.id and [Type] = 'D' and VoucherId <> bpd.CRId and VoucherType like '% RECEIPT VOUCHER')) as Balance,
bpd.[Desc] as [Desc],
Cast(bpd.Amount as decimal(18,2)) as Amount,Cast('false' as bit) as [Select]
from OrderMaster i
inner join CashReceiptDetail bpd on i.id = bpd.SaleId
where bpd.CRId = @id

end
else if @Type = 'BANK'
begin
Select i.id as InvoiceId,i.OrderNo as InvoiceNo,
((select isnull(sum(Amount),0) from CustomerLedger where VN = i.OrderNo and [Type] = 'C')- 
--(select isnull(sum(TotalAmount),0) from PurchaseReturnMaster where InvoiceId = i.InvoiceId)
0) as TotalAmount,
(select isnull(sum(Amount),0) from CustomerLedger where SaleId = i.id and [Type] = 'D' and VoucherId <> bpd.BRId
 and VoucherType like '% RECEIPT VOUCHER') as TotalPaid,
(((select isnull(sum(Amount),0) from SupplierLedger where VN = i.OrderNo and [Type] = 'C')- 
--(select isnull(sum(TotalAmount),0) from PurchaseReturnMaster where InvoiceId = i.InvoiceId)
0)-
(select isnull(sum(Amount),0) from CustomerLedger where SaleId = i.id and [Type] = 'D' and VoucherId <> bpd.BRId and VoucherType like '% RECEIPT VOUCHER')) as Balance,
bpd.[Desc] as [Desc],
Cast(bpd.Amount as decimal(18,2)) as Amount,Cast('false' as bit) as [Select]
from OrderMaster i
inner join BankReceiptDetail bpd on i.id = bpd.SaleId
where bpd.BRId = @id


end



