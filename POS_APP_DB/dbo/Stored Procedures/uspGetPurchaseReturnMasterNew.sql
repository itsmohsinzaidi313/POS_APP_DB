CREATE proc [dbo].[uspGetPurchaseReturnMasterNew]
--@VId as int
as
Select m.PRId as GRNId,m.Date,m.PRNo ,grn.GRNo,v.Vendor,m.RefrenceNo,m.Amount,
m.Discount,m.TotalAmount,m.VId,m.TotalTax
from PurchaseReturnMasterNew m  
inner join GRNMAster grn on m.GRNId = grn.GRNId
inner join Vendor v on m.Vid=v.Vid
--where m.VId=@VId