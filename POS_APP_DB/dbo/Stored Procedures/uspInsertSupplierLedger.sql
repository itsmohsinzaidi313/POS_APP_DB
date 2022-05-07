CREATE proc [dbo].[uspInsertSupplierLedger]

@VId as int,
@VoucherId as int,
@Amount as decimal(18,2),
@Type as nvarchar(10),
@VoucherType as nvarchar(10),
@COId as int,
@Date as Datetime

as

insert into SupplierLedger (VId,VoucherId,Amount,[Type],VoucherType,COId,Date)
values 
(@VId,@VoucherId,@Amount,@Type,@VoucherType,@COId,@Date)
