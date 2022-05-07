CREATE proc [dbo].[uspInsertReceipt]
@VN as nvarchar(50),
@Date datetime,
@CustId int,
@Amount decimal(18,2),
@PaymentMode nvarchar(50),
@COId int,
@ChequeNo nvarchar(50),
@ChequeDate nvarchar(50),
@CAId int,
@ReceiveFrom nvarchar(MAX),
@For nvarchar(MAX),
@XML xml,
--@SupAccId int,
--@AssetAccId int,
@Type as nvarchar(50)
--@XML2 xml

as

BEGIN TRY
   BEGIN TRANSACTION   

DECLARE @PVId int;
DECLARE @BPId int;
DECLARE @CPId int;
DECLARE @CLId int;

Declare @APId int;
select @APId = max(APId) from AccountPeriod where IsActive = 1

insert into ReceiptVoucher
(
Date,
CustId,
Amount,
ReceiptMode,
COId,
Type
)
values 
(
@Date,
@CustId,
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
insert into BankReceiptMaster
(
VN,
RVId,
Date,
TotalAmount,
ChequeNo,
ChequeDate,
CAId,
ReceiveFrom,
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
@ReceiveFrom,
@For,
@COId)
SET @BPId = SCOPE_IDENTITY();
if @BPId > 0
Begin

INSERT INTO BankReceiptDetail
    (BRId,Amount,CAId,[Desc])
SELECT 
@BPId,
          myXML.value('./@Amount', 'decimal(18,2)')
         , myXML.value('./@CAId', 'int')
, myXML.value('./@Desc', 'nvarchar(MAX)')	
    FROM @XML.nodes('/doc/title') As nodes(myXML);

    SET NOCOUNT OFF;
End
End
else if @PaymentMode = 'CASH'
Begin
insert into CashReceiptMaster
(
VN,
RVId,
Date,
TotalAmount,
ReceiveFrom,
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
@ReceiveFrom,
@For,
@COId,
@CAId
)
SET @CPId = SCOPE_IDENTITY();
if @CPId > 0
Begin
INSERT INTO CashReceiptDetail
    (CRId,Amount,CAId,[Desc])
SELECT 
@CPId,
          myXML.value('./@Amount', 'decimal(18,2)')
         , myXML.value('./@CAId', 'int')
, myXML.value('./@Desc', 'nvarchar(MAX)')	
    FROM @XML.nodes('/doc/title') As nodes(myXML);

    SET NOCOUNT OFF;

End
End


End

COMMIT

set @CLId=0
select @CustId = CustId from ReceiptVoucher where RVId = (select max(RVId) from ReceiptVoucher)

if @PaymentMode = 'BANK'
Begin
--EXECUTE [uspInsertGL] 'C',@BPId,@Date,@Amount,@AssetAccId,'BANK RECEIPT VOUCHER',@COId,@VN
--EXECUTE [uspInsertGL] 'D',@BPId,@Date,@Amount,@SupAccId,'BANK RECEIPT VOUCHER',@COId,@VN

Declare @RType nvarchar(max);
if @CustId > 0 
Begin

EXECUTE [uspInsertCustomerLedger]@BPId,@Amount,'D',@CustId,@Date,@COId,'BANK RECEIPT VOUCHER',@VN,@BPId

End

INSERT INTO GL
    (
[Type],
VN,
VoucherId,
Date,
Amount,
CAId,
VoucherType,
COId,
APId    )
SELECT 
myXML.value('./@Type', 'varchar(10)'),
@VN,@BPId,@Date, 
myXML.value('./@Amount', 'decimal(18,2)'),
myXML.value('./@CAId', 'int'),'BANK RECEIPT VOUCHER',@COId,@APId

           
    FROM @XML.nodes('/doc/title') As nodes(myXML);



End
else if @PaymentMode = 'CASH'
Begin
--EXECUTE [uspInsertGL] 'C',@CPId,@Date,@Amount,@AssetAccId,'CASH RECEIPT VOUCHER',@COId,@VN
--EXECUTE [uspInsertGL] 'D',@CPId,@Date,@Amount,@SupAccId,'CASH RECEIPT VOUCHER',@COId,@VN

if @CustId > 0 
Begin

EXECUTE [uspInsertCustomerLedger]@CPId,@Amount,'D',@CustId,@Date,@COId,'CASH RECEIPT VOUCHER',@VN,@CPId

End

INSERT INTO GL
    (
[Type],
VN,
VoucherId,
Date,
Amount,
CAId,
VoucherType,
COId,
APId    )
SELECT 
myXML.value('./@Type', 'varchar(10)'),
@VN,@CPId,@Date, 
myXML.value('./@Amount', 'decimal(18,2)'),
myXML.value('./@CAId', 'int'),'CASH RECEIPT VOUCHER',@COId,@APId

           
    FROM @XML.nodes('/doc/title') As nodes(myXML);

End

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back

EXECUTE [uspGetErrorInfo]

END CATCH



















