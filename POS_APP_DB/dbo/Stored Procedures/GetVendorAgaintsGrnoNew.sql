CREATE proc [dbo].[GetVendorAgaintsGrnoNew]--'GRN-0001'
@GRNo as nvarchar(50)
as
select v.VId,Vendor from Vendor v 

inner join GRNMaster grm on
v.VId=grm.VId
where GRNo=@GRNo 





