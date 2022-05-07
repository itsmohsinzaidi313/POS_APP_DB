
create Proc [dbo].[GetCustomerSaleInvoiceMasterData]--85,0
@SId as int,
@BRId as int
as
--Select m.GRNId,m.Date,m.GRNo as [G.R.No],v.Vendor,m.RefrenceNo,m.Amount,
--m.Discount,m.TotalAmount,m.VId
--from GRNMaster m 
--inner join Vendor v on m.Vid=v.Vid
--
--where m.Sid=@Sid and m.BRId=@BRId 

Select m.SLId,m.Date,m.SaleInvoiceNo as [G.R.No],v.Customer,m.RefrenceNo,m.Amount,
m.Discount,m.TotalAmount,m.CustId,m.TotalTax
from CustomerSaleInvoiceMaster m 
inner join Customer v on m.CustId=v.CustId
where m.Sid=@Sid and m.BRId=@BRId 
--and NOT EXISTS
--(
--select * from InvoiceMaster_Company where GRNId = m.GRNId
--)
