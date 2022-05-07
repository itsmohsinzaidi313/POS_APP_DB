create proc [dbo].[uspGetInvoicesForReceiptByCustomerId]--12
@CustId as int
as
select i.id as InvoiceId,i.OrderNo as InvoiceNo,
((select isnull(sum(Amount),0) from CustomerLedger where VN = i.OrderNo and [Type] = 'C')) as TotalAmount,
(select isnull(sum(Amount),0) from CustomerLedger where SaleId = i.id and [Type] = 'D' and VoucherType like '% RECEIPT VOUCHER') as TotalPaid,
(((select isnull(sum(Amount),0) from CustomerLedger where VN = i.OrderNo and [Type] = 'C'))-
(select isnull(sum(Amount),0) from CustomerLedger where SaleId = i.id and [Type] = 'D' and VoucherType like '% RECEIPT VOUCHER')) as Balance,
'' as [Desc],
Cast('0' as decimal(18,2)) as Amount,Cast('false' as bit) as [Select]
from OrderMaster i where i.CustomerId = @CustId