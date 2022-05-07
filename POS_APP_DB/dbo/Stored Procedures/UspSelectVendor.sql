CREATE proc [dbo].[UspSelectVendor]
as
select Vendor.VId,Vendor.Vendor,Vendor.Address,Vendor.CellNo,Vendor.OpBalance,
Vendor.Fax,Vendor.Email,
Company.Coid,Company.Company,Vendor.CAId  from Vendor
inner join Company on
Company.COId=Vendor.COId
 

