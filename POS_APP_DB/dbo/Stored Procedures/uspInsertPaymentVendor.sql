
create proc [dbo].[uspInsertPaymentVendor]
@VN as nvarchar(50),
@Date datetime,
@SPId int,
@Amount decimal(18,2),
@PaymentMode nvarchar(50),
@COId int,
@ChequeNo nvarchar(50),
@ChequeDate nvarchar(50),
@CAId int,
@PaidTo nvarchar(MAX),
@For nvarchar(MAX),
@XML xml,
@SupAccId int,
@AssetAccId int,
@Type as nvarchar(50)

as

BEGIN TRY
   BEGIN TRANSACTION   

DECLARE @PVId int;
DECLARE @BPId int;
DECLARE @CPId int;
DECLARE @CLId int;
insert into PaymentVoucher
(
Date,
SPId,
Amount,
PaymentMode,
COId,
Type
)
values 
(
@Date,
@SPId,
@Amount,
@PaymentMode,
@COId,
@Type
)
SET @PVId = SCOPE_IDENTITY();

if @PVId > 0
Begin

if @PaymentMode = 'BANK'
Begin
insert into BankPaymentMaster
(
VN,
PVId,
Date,
TotalAmount,
ChequeNo,
ChequeDate,
CAId,
PaidTo,
[For],
COId)
values 
(
@VN,
@PVId,
@Date,
@Amount,
@ChequeNo,
@ChequeDate,
@CAId,
@PaidTo,
@For,
@COId)
SET @BPId = SCOPE_IDENTITY();
if @BPId > 0
Begin

INSERT INTO BankPaymentDetail
    (BPId,Amount,CAId,[Desc],InvoiceId)
SELECT 
@BPId,
          myXML.value('./@Amount', 'decimal(18,2)')
--         , myXML.value('./@CAId', 'int')
, @SupAccId
, myXML.value('./@Desc', 'nvarchar(MAX)')
, myXML.value('./@InvoiceId', 'int')

    FROM @XML.nodes('/doc/title') As nodes(myXML);

insert into SupplierLedger(VoucherId,Amount,[Type],VId,Date,COId,VoucherType,VN,InvoiceId)
Select @BPId,
          myXML.value('./@Amount', 'decimal(18,2)'),
'D',@SPId,@Date,@COId,'BANK PAYMENT VOUCHER',@VN,
myXML.value('./@InvoiceId', 'int')
  FROM @XML.nodes('/doc/title') As nodes(myXML);

    SET NOCOUNT OFF;
End
End
else if @PaymentMode = 'CASH'
Begin
insert into CashPaymentMaster
(
VN,
PVId,
Date,
TotalAmount,
PaidTo,
[For],
COId,
CAId

)
values 
(
@VN,
@PVId,
@Date,
@Amount,
@PaidTo,
@For,
@COId,
@CAId
)
SET @CPId = SCOPE_IDENTITY();
if @CPId > 0
Begin
INSERT INTO CashPaymentDetail
    (CPId,Amount,CAId,[Desc],InvoiceId)
SELECT 
@CPId,
          myXML.value('./@Amount', 'decimal(18,2)')
--         , myXML.value('./@CAId', 'int')
, @SupAccId

, myXML.value('./@Desc', 'nvarchar(MAX)')	,
myXML.value('./@InvoiceId', 'int')

    FROM @XML.nodes('/doc/title') As nodes(myXML);


insert into SupplierLedger(VoucherId,Amount,[Type],VId,Date,COId,VoucherType,VN,InvoiceId)
Select @CPId,
          myXML.value('./@Amount', 'decimal(18,2)'),
'D',@SPId,@Date,@COId,'CASH PAYMENT VOUCHER',@VN,
myXML.value('./@InvoiceId', 'int')
  FROM @XML.nodes('/doc/title') As nodes(myXML);

    SET NOCOUNT OFF;

End
End


End
COMMIT
set @CLId=0
if @PaymentMode = 'BANK'
Begin
--EXECUTE [uspInsertSupplierLedger] @BPId,@Amount,'D',@SPId,@Date,@COId,'BANK PAYMENT VOUCHER',@VN
EXECUTE [uspInsertGL] 'C',@BPId,@Date,@Amount,@AssetAccId,'BANK PAYMENT VOUCHER',@COId,@VN
EXECUTE [uspInsertGL] 'D',@BPId,@Date,@Amount,@SupAccId,'BANK PAYMENT VOUCHER',@COId,@VN
--Execute [InsertProjectLedger]@BPId,@Amount,'D',@Date,@COId,'BANK PAYMENT VOUCHER',@VN,@XML

End
else if @PaymentMode = 'CASH'
Begin
--EXECUTE [uspInsertSupplierLedger] @CPId,@Amount,'D',@SPId,@Date,@COId,'CASH PAYMENT VOUCHER',@VN
EXECUTE [uspInsertGL] 'C',@CPId,@Date,@Amount,@AssetAccId,'CASH PAYMENT VOUCHER',@COId,@VN
EXECUTE [uspInsertGL] 'D',@CPId,@Date,@Amount,@SupAccId,'CASH PAYMENT VOUCHER',@COId,@VN
--Execute [InsertProjectLedger]@CPId,@Amount,'D',@Date,@COId,'CASH PAYMENT VOUCHER',@VN,@XML


End

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back

EXECUTE [uspGetErrorInfo]

END CATCH