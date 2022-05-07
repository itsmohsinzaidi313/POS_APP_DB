create Proc [dbo].[uspGetJVMaster]
as
Select JVId,VN as [Voucher No],Date from JvMAster
