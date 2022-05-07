CREATE Proc [dbo].[GetPurchaseReturndataNew]
@SId as int,
@BRId as int
as
Select pm.PRId,pm.Date,pm.PRNo,
v.Vendor,pm.RefNo,pm.Amount,pm.TotalAmount,pm.VId,
im.InvoiceNo,pm.InvoiceId
from PurchaseReturnMaster pm
 inner join Vendor v on pm.Vid=v.Vid
inner join InvoiceMaster_Company im on im.InvoiceId=pm.InvoiceId
where pm.Sid=@Sid and pm.BRId=@BRId









