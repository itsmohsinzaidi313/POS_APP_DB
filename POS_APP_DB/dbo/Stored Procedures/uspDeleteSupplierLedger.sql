
CREATE proc [dbo].[uspDeleteSupplierLedger]

@VoucherId as int,
@COId as int

as
Delete from SupplierLedger where VoucherId = @VoucherId and COId = @COId

select * from SupplierLedger where VoucherId = @VoucherId