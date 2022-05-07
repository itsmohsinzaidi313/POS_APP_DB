create proc [dbo].[uspInsertSaleInvoice]

@InvoiceNo nvarchar(50),
--@RefInvoiceNo nvarchar(50),
@UserId int,
@Date datetime,
@Amount decimal(18,2),
@Discount decimal(18,2),
@TotalAmount decimal(18,2),
@COId int,
@CustId int,
@XML  XML,
@AssetAccId int,
@CustAccId int,
@ProId int,
@SaleInvoiceId int

as

BEGIN TRY
   BEGIN TRANSACTION   
if @SaleInvoiceId =0
begin
insert into SaleInvoiceMaster
(
SaleInvoiceNo,
UserId,
Date,
Amount,
Discount,
TotalAmount,
COId,
CustId,
ProId
)
values 
(
@InvoiceNo,
@UserId,
@Date,
@Amount,
@Discount,
@TotalAmount,
@COId,
@CustId,
@ProId
)
SET @SaleInvoiceId = SCOPE_IDENTITY();
INSERT INTO SaleInvoiceDetail
    (SaleInvoiceId,[Desc],Amount,CAId)
SELECT 
@SaleInvoiceId,myXML.value('./@Desc', 'varchar(MAX)'), myXML.value('./@Amount', 'decimal(18,2)'), myXML.value('./@CAId', 'decimal(18,2)')		
FROM @XML.nodes('/doc/title') As nodes(myXML);
SET NOCOUNT OFF;
end
else if @SaleInvoiceId >0
begin
update SaleInvoiceMaster set SaleInvoiceNo = @InvoiceNo ,
UserId =@UserId,
Date =@Date ,
Amount =@Amount,
Discount =@Discount,
TotalAmount=@TotalAmount,
COId=@COId,
CustId=@CustId
--,
--ProId=@ProId
where SaleInvoiceId = @SaleInvoiceId

INSERT INTO SaleInvoiceDetail
    (SaleInvoiceId,[Desc],Amount,CAId)
SELECT 
@SaleInvoiceId,myXML.value('./@Desc', 'varchar(MAX)'), myXML.value('./@Amount', 'decimal(18,2)'), myXML.value('./@CAId', 'decimal(18,2)')			
FROM @XML.nodes('/doc/title') As nodes(myXML);
SET NOCOUNT OFF;
end




COMMIT
--set @CLId=0
if @SaleInvoiceId >0
begin

Declare @APId int;
select @APId = max(APId) from AccountPeriod where IsActive = 1

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
@InvoiceNo,@SaleInvoiceId,@Date, 
myXML.value('./@Amount', 'decimal(18,2)'),
myXML.value('./@CAId', 'int'),'SALE VOUCHER',@COId,@APId

           
    FROM @XML.nodes('/doc/title') As nodes(myXML);

--EXECUTE [uspInsertGL] 'D',@SaleInvoiceId,@Date,@TotalAmount,@AssetAccId,'SALE VOUCHER',@COId,@InvoiceNo
--EXECUTE [uspInsertGL] 'C',@SaleInvoiceId,@Date,@TotalAmount,@CustAccId,'SALE VOUCHER',@COId,@InvoiceNo

EXECUTE [uspInsertCustomerLedger] @SaleInvoiceId,@TotalAmount,'C',@CustId,@Date,@COId,'SALE VOUCHER',@InvoiceNo,@SaleInvoiceId
--EXECUTE [uspInsertProjectLedger] @SaleInvoiceId,@TotalAmount,'D',@ProId,@Date,@COId,'SALE VOUCHER',@InvoiceNo
end

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH













