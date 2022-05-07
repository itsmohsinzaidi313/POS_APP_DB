CREATE proc [dbo].[uspGetGRNNoByVendorId]
@VId as int
as
select g.GRNId,g.GRNo from GRNMaster g where g.VId = @VId
and 
not EXISTS
(
select * from InvoiceDetail_CompanyNew pd where g.GRNId = pd.GRNId 
)
order by g.GRNo


