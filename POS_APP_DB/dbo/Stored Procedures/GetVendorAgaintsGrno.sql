Create proc [dbo].[GetVendorAgaintsGrno]
@VId as int
as
select GRNId,GRNo from GRNMaster where VId=@VId





