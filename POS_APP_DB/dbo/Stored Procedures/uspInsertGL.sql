create proc [dbo].[uspInsertGL]

@Type nvarchar(50),
@VoucherId int,
@Date datetime,
@Amount decimal(18,2),
@CAId int,
@VoucherType nvarchar(50),
@COId int,
@VN nvarchar(50)
as

BEGIN TRY
   BEGIN TRANSACTION   

insert into GL([Type],VoucherId,Date,Amount,CAId,VoucherType,COId,VN)
values 
(@Type,@VoucherId,@Date,@Amount,@CAId,@VoucherType,@COId,@VN)

COMMIT



END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH


