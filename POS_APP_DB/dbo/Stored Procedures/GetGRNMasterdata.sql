CREATE Proc [dbo].[GetGRNMasterdata]
@SId as int,
@BRId as int
as
Select m.GRNId,m.Date,m.GRNo as [G.R.No],v.Vendor,i.InvoiceId,i.InvoiceNo,m.Amount,m.Discount,m.TotalAmount,m.VId
from GRNMaster m inner join Vendor v on m.Vid=v.Vid
inner join InvoiceMaster_Company i on m.GRNId=i.GRNId
where m.Sid=@Sid and m.BRId=@BRId

