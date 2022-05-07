create proc [dbo].[uspGetRecordFromGLByVoucherIdAndType]
@VoucherId as int,
@VoucherType as nvarchar(50)
as
select * from GL where VoucherId = @VoucherId and VoucherType = @VoucherType
