
create proc [dbo].[UspBindINVByDateVendor]--'6/26/2013 12:00:00 AM','7/28/2013 12:00:00 AM'
@From as datetime,
@To as Datetime,
@VId as int
as
select 
INV.InvoiceId,INV.InvoiceNo from InvoiceMaster_CompanyNew INV
where Date between @From and @To and VId = @VId