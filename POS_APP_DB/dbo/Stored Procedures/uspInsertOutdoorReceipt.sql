

CREATE proc [dbo].[uspInsertOutdoorReceipt]
@VN as nvarchar(50),
@Date datetime,
@CustId int,
@Amount decimal(18,2),
@ReceiptMode nvarchar(50),
@COId int,
@ChequeNo nvarchar(50),
@ChequeDate nvarchar(50),
@CAId int,
@ReceiveFrom nvarchar(MAX),
@For nvarchar(MAX),
@XML xml,
@SupAccId int,
@AssetAccId int,
@Type as nvarchar(50)

as

BEGIN TRY
   BEGIN TRANSACTION   

DECLARE @RVId int;
DECLARE @BRId int;
DECLARE @CRId int;
DECLARE @CLId int;

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
@ReceiptMode,
@COId,
@Type
)
SET @RVId = SCOPE_IDENTITY();

if @RVId > 0
Begin

if @ReceiptMode = 'BANK'
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
@RVId,
@Date,
@Amount,
@ChequeNo,
@ChequeDate,
@CAId,
@ReceiveFrom,
@For,
@COId)
SET @BRId = SCOPE_IDENTITY();
if @BRId > 0
Begin

INSERT INTO BankReceiptDetail
    (BRId,Amount,CAId,[Desc],SaleId)
SELECT 
@BRId,
          myXML.value('./@Amount', 'decimal(18,2)')
--         , myXML.value('./@CAId', 'int')
, @SupAccId
, myXML.value('./@Desc', 'nvarchar(MAX)')
, myXML.value('./@InvoiceId', 'int')
    FROM @XML.nodes('/doc/title') As nodes(myXML);

insert into CustomerLedger(VoucherId,Amount,[Type],CustId,Date,COId,VoucherType,VN,SaleId)
Select @BRId,@Amount,'D',@CustId,@Date,@COId,'BANK RECEIPT VOUCHER',@VN,
myXML.value('./@InvoiceId', 'int')
  FROM @XML.nodes('/doc/title') As nodes(myXML);

--EXECUTE [uspInsertCustomerLedger]@BRId,@Amount,'D',@CustId,@Date,@COId,'BANK RECEIPT VOUCHER',@VN
--, myXML.value('./@InvoiceId', 'int')
--    FROM @XML.nodes('/doc/title') As nodes(myXML);


    SET NOCOUNT OFF;
End
End
else if @ReceiptMode = 'CASH'
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
@RVId,
@Date,
@Amount,
@ReceiveFrom,
@For,
@COId,
@CAId
)
SET @CRId = SCOPE_IDENTITY();
if @CRId > 0
Begin
INSERT INTO CashReceiptDetail
    (CRId,Amount,CAId,[Desc],SaleId)
SELECT 
@CRId,
          myXML.value('./@Amount', 'decimal(18,2)')
--         , myXML.value('./@CAId', 'int')
, @SupAccId

, myXML.value('./@Desc', 'nvarchar(MAX)')	
, myXML.value('./@InvoiceId', 'int')

    FROM @XML.nodes('/doc/title') As nodes(myXML);


insert into CustomerLedger(VoucherId,Amount,[Type],CustId,Date,COId,VoucherType,VN,SaleId)
Select @CRId,@Amount,'D',@CustId,@Date,@COId,'CASH RECEIPT VOUCHER',@VN,
myXML.value('./@InvoiceId', 'int')
  FROM @XML.nodes('/doc/title') As nodes(myXML);

--EXECUTE [uspInsertCustomerLedger]@CRId,@Amount,'D',@CustId,@Date,@COId,'CASH RECEIPT VOUCHER',@VN
--,myXML.value('./@InvoiceId', 'int')
--    FROM @XML.nodes('/doc/title') As nodes(myXML);

    SET NOCOUNT OFF;

End
End


End
COMMIT
set @CLId=0
if @ReceiptMode = 'BANK'
Begin
--EXECUTE [uspInsertSupplierLedger] @BPId,@Amount,'D',@SPId,@Date,@COId,'BANK PAYMENT VOUCHER',@VN
EXECUTE [uspInsertGL] 'D',@BRId,@Date,@Amount,@AssetAccId,'BANK RECEIPT VOUCHER',@COId,@VN
EXECUTE [uspInsertGL] 'C',@BRId,@Date,@Amount,@SupAccId,'BANK RECEIPT VOUCHER',@COId,@VN
--Execute [InsertProjectLedger]@BPId,@Amount,'D',@Date,@COId,'BANK PAYMENT VOUCHER',@VN,@XML

End
else if @ReceiptMode = 'CASH'
Begin
--EXECUTE [uspInsertSupplierLedger] @CPId,@Amount,'D',@SPId,@Date,@COId,'CASH PAYMENT VOUCHER',@VN
EXECUTE [uspInsertGL] 'D',@CRId,@Date,@Amount,@AssetAccId,'CASH RECEIPT VOUCHER',@COId,@VN
EXECUTE [uspInsertGL] 'C',@CRId,@Date,@Amount,@SupAccId,'CASH RECEIPT VOUCHER',@COId,@VN
--Execute [InsertProjectLedger]@CPId,@Amount,'D',@Date,@COId,'CASH PAYMENT VOUCHER',@VN,@XML


End

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back

EXECUTE [uspGetErrorInfo]

END CATCH

select @RVId;