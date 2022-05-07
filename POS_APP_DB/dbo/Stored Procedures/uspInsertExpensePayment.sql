create proc [dbo].[uspInsertExpensePayment]
@VN as nvarchar(50),
@Date datetime,
@SPId int,
@Amount decimal(18,2),
@PaymentMode nvarchar(50),
@COId int,
@ChequeNo  nvarchar(MAX),
@ChequeDate nvarchar(MAX),
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
    (BPId,Amount,CAId,[Desc])
SELECT 
@BPId,
          myXML.value('./@Amount', 'decimal(18,2)')
         , myXML.value('./@CAId', 'int')
, myXML.value('./@Desc', 'nvarchar(MAX)')	
    FROM @XML.nodes('/doc/title') As nodes(myXML);


INSERT INTO GL
    ([Type],VN,VoucherId,Date,Amount,CAId,VoucherType,COID)
SELECT 
'D',@VN,@BPId,@Date,
          myXML.value('./@Amount', 'decimal(18,2)')
         , myXML.value('./@CAId', 'int'),'BANK PAYMENT VOUCHER'
, @COId
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
    (CPId,Amount,CAId,[Desc])
SELECT 
@CPId,
          myXML.value('./@Amount', 'decimal(18,2)')
         , myXML.value('./@CAId', 'int')
, myXML.value('./@Desc', 'nvarchar(MAX)')	
    FROM @XML.nodes('/doc/title') As nodes(myXML);

INSERT INTO GL
    ([Type],VN,VoucherId,Date,Amount,CAId,VoucherType,COID)
SELECT 
'D',@VN,@CPId,@Date,
          myXML.value('./@Amount', 'decimal(18,2)')
         , myXML.value('./@CAId', 'int'),'CASH PAYMENT VOUCHER'
, @COId
    FROM @XML.nodes('/doc/title') As nodes(myXML);



    SET NOCOUNT OFF;

End
End


End
COMMIT
set @CLId=0
if @PaymentMode = 'BANK'
Begin
EXECUTE [uspInsertGL] 'C',@BPId,@Date,@Amount,@AssetAccId,'BANK PAYMENT VOUCHER',@COId,@VN
--EXECUTE [uspInsertGL] 'D',@BPId,@Date,@Amount,@SupAccId,'BANK PAYMENT VOUCHER',@COId,@VN
--Execute [InsertProjectLedger]@BPId,@Amount,'C',@Date,@COId,'BANK PAYMENT VOUCHER',@VN,@XML

--insert into ProjectLedger
--(VoucherId,[Type],Date,COId,VoucherType,VN,Amount,ProId) 
--
--SELECT 
--@BPId,'D',@Date,@COId,'BANK PAYMENT VOUCHER',@VN,
--          myXML.value('./@Amount', 'decimal(18,2)')
--         , myXML.value('./@ProId', 'int')
--    FROM @XML.nodes('/doc/title') As nodes(myXML);
-- 
--    SET NOCOUNT OFF;


End
else if @PaymentMode = 'CASH'
Begin
EXECUTE [uspInsertGL] 'C',@CPId,@Date,@Amount,@AssetAccId,'CASH PAYMENT VOUCHER',@COId,@VN
--EXECUTE [uspInsertGL] 'D',@CPId,@Date,@Amount,@SupAccId,'CASH PAYMENT VOUCHER',@COId,@VN
--Execute [InsertProjectLedger]@CPId,@Amount,'C',@Date,@COId,'CASH PAYMENT VOUCHER',@VN,@XML


--insert into ProjectLedger
--(VoucherId,[Type],Date,COId,VoucherType,VN,Amount,ProId) 
--
--SELECT 
--@CPId,'D',@Date,@COId,'CASH PAYMENT VOUCHER',@VN,
--          myXML.value('./@Amount', 'decimal(18,2)')
--         , myXML.value('./@ProId', 'int')
--    FROM @XML.nodes('/doc/title') As nodes(myXML);
-- 
--    SET NOCOUNT OFF;


End

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back

EXECUTE [uspGetErrorInfo]

END CATCH









