CREATE proc [dbo].[GetVendorAgaintsInv]--'GRN-0001'
@InvoiceNo as nvarchar(50)
as
select v.VId,Vendor from Vendor v 

inner join InvoiceMaster_Company grm on
v.VId=grm.VId
where InvoiceNo=@InvoiceNo 







