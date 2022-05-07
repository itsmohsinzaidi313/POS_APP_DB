create proc [dbo].[GetSupplier]
as
Select VId as SPId,Vendor as [Name] from Vendor order by Vendor