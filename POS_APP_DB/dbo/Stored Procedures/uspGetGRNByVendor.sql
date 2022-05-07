CREATE proc [dbo].[uspGetGRNByVendor]
@VId as int
as
select g.VId,g.GRNId,g.Date,g.GRNo,g.RefrenceNo,g.Amount,g.TotalTax,g.Discount,g.TotalAmount,Cast('0' as bit) as IsSeleted
from GRNMaster g
inner join Vendor v on g.VId = v.VId
where g.VId = @VId and
not exists 
(
select * from InvoiceDetail_CompanyNew where GRNId = g.GRNId
)

