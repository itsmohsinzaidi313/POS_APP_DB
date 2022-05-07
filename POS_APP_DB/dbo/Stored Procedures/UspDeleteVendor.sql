
CREATE proc [dbo].[UspDeleteVendor]--28

@VId as int

as

begin try
begin Transaction

Declare @IsExist int;
set @IsExist = 0;

delete from Vendor
where
VId=@VId

Commit

Declare @COId int;
Declare @APId int;
Declare @CAId as int;
Declare @Op as decimal(18,2);
Declare @AcOp as decimal(18,2);
Declare @FinalOp as decimal(18,2);
Declare @PreOp as decimal(18,2);

set @COId = 0;
set @CAId = 0;
set @Op = 0;
set @APId = 0;
set @AcOp = 0;
set @FinalOp = 0;
set @PreOp = 0;

select @CAId = CAId , @Op = OpBalance, @PreOp = PreOp, @COId = COId from Vendor where VId = @VId
select @APId = APId from AccountPeriod where COId = @COId and IsActive = 1
select @AcOp = Amount from AccountOpenBalance where APId = @APId and CAId = @CAId

set @FinalOp = (@AcOp - @Op);

Update AccountOpenBalance set Amount = @FinalOp where CAId = @CAId and APId = @APId
delete from SupplierLedger where VoucherType = 'Advance' and VoucherId = 0 and VId = @VId

end try
begin catch
if @@Trancount>0
Rollback
exec uspGetErrorInfo
end catch

select @IsExist = VId from Vendor where VId = @VId
