CREATE Proc [dbo].[GetInvoicedataNew]
@SId as int,
@BRId as int
as
--Select im.InvoiceId,im.Date,im.InvoiceNo,v.Vendor,im.RefrenceNo,
--im.Amount,im.Discount,im.TotalAmount,im.VId,gm.GRNo as GRNo,im.GRNId,TotalTax 
--from InvoiceMaster_Company im 
--inner join Vendor v on im.VId=v.VId
--inner join GRNMaster gm on gm.GRNId=im.GRNId
--where im.Sid=@Sid and im.BRId=@BRId

Select im.InvoiceId,im.Date,im.InvoiceNo,v.Vendor,im.RefrenceNo,
im.Amount,im.Discount,im.TotalAmount,im.VId,gm.GRNo,im.GRNId,im.TotalTax 
from InvoiceMaster_Company im 
inner join Vendor v on im.VId=v.VId
inner join GRNMaster gm on gm.GRNId=im.GRNId
where im.Sid=@Sid and im.BRId=@BRId