create proc [dbo].[uspInsertCustomerLedger]

@VoucherId int,
@Amount decimal(18,2),
@Type nvarchar(50),
@CustId int,
@Date datetime,
@COId int,
@VoucherType nvarchar(50),
@VN nvarchar(50),
@SaleId int

as

BEGIN TRY
   BEGIN TRANSACTION   

insert into CustomerLedger(VoucherId,Amount,[Type],CustId,Date,COId,VoucherType,VN,SaleId)
values 
(@VoucherId,@Amount,@Type,@CustId,@Date,@COId,@VoucherType,@VN,@SaleId)
COMMIT



END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH




