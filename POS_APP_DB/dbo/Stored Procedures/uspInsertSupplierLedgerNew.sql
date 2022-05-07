

CREATE proc [dbo].[uspInsertSupplierLedgerNew]

@VId as int,
@VoucherId as int,
@Amount as decimal(18,2),
@Type as nvarchar(10),
@VoucherType as nvarchar(10),
@COId as int,
@Date as Datetime,
@VN as nvarchar(10),
@InvoiceId as int,
@IsAdvance as bit
as

Declare @id as int;
set @id = 0;

insert into SupplierLedger (VId,VoucherId,Amount,[Type],VoucherType,COId,Date,VN,InvoiceId,IsAdvance)
values 
(@VId,@VoucherId,@Amount,@Type,@VoucherType,@COId,@Date,@VN,@InvoiceId,@IsAdvance)
set @id = scope_identity();

--if @id > 0
--Begin
--Declare @CAId as int;
--set @CAId = 0;
--select @CAId = isnull(CAId,0) from Vendor where VId = @VId
--
--insert into GL ([Type],VN,VoucherId,Date,Amount,CAId,VoucherType,COId)
--values
--('C',@VN,@id,@Date,@Amount,@CAId,'PURCHASE',@COId)
--End

select @id;
