
CREATE proc [dbo].[UspGetVendorLedger]--'6/26/2013 12:00:00 AM','10/04/2013 12:00:00 AM','13'
@From as datetime,
@To as Datetime,
@VendorId as text
as
Declare @Cheque as nvarchar(50);
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],@Cheque as Cheque,
v.VId,v.Vendor,sl.Date,sl.VoucherType,[dbo].[GetInvoiceNoForSupplyledgerReportNew](sl.Id)as PINO,
((select isnull(sum(Amount),0) from SupplierLedger where VId = v.VId and [Type] = 'D' and Date < @From) -
(select isnull(sum(Amount),0) from SupplierLedger where  VId = v.VId and [Type] = 'C' and Date < @From)) as OpenBalance ,
(select isnull(sum(Amount),0) from SupplierLedger where Id = sl.Id and [Type] = 'D' ) as Debit,
(select isnull(sum(Amount),0) from SupplierLedger where Id = sl.Id and [Type] = 'C' ) as Credit,
--(select isnull(sum(Amount),0) from SupplierLedger where Date = sl.Date and VId = v.VId and [Type] = 'D') as Debit,
--
--(select isnull(sum(Amount),0) from SupplierLedger where Date = sl.Date and VId = v.VId and [Type] = 'C') as Credit,

(((select isnull(sum(Amount),0) from SupplierLedger where  VId = v.VId and [Type] = 'D' and Date < @From) -
(select isnull(sum(Amount),0) from SupplierLedger where  VId = v.VId and [Type] = 'C' and Date < @From)) +
 
(select isnull(sum(Amount),0) from SupplierLedger where VId = v.VId and [Type] = 'D' and Date = sl.Date) -

(select isnull(sum(Amount),0) from SupplierLedger where VId = v.VId and [Type] = 'C' and Date = sl.Date)) as Balance

from Vendor v 
inner join SupplierLedger sl on v.VId = sl.VId
inner join Split(@VendorId,',') sp on sp.items = v.VId
where sl.Date between @From and @To