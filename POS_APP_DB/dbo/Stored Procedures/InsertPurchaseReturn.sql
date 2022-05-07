

CREATE proc [dbo].[InsertPurchaseReturn]

@Date as datetime,
@UserId as int,
@VId as int,
@PRNo as nvarchar(50),
@SId as  int,
@BRId as  int,
@Amount as decimal(18,2),
@Discount as decimal(18,2),
@TotalAmount as decimal(18,2),
@XML as xml,
@InvoiceId as int,
@RefNo as nvarchar(50),
@TotalTax as decimal(18,2),
@COId as int

as
BEGIN TRY
   BEGIN TRANSACTION 
DECLARE @PRId int;

Insert into PurchaseReturnMaster
(
Date ,
UserId ,
VId ,
PRNo,
SId ,
BRId ,
Amount,
Discount ,
TotalAmount ,
InvoiceId,
RefNo,
TotalTax,
COId

)
values
(
@Date ,
@UserId ,
@VId ,
@PRNo,
@SId ,
@BRId ,
@Amount,
@Discount ,
@TotalAmount ,
@InvoiceId,
@RefNo,
@TotalTax,
@COId

)

SET @PRId = SCOPE_IDENTITY();

if @PRId > 0
Begin

Insert into PurchaseReturnDetail
(
PRId,
ItemId,
Unit,
Rate,
QTY ,
POId,
TotalPackage,
PcsPerPackage,
RatePerPackage,
PackageId,
GRNId,
DSCOId,
DiscountPerPcs,
TaxPerPcs,
TaxType,
NetAmount,
Amount,
TaxMode

)

SELECT 
@PRId,


 myXML.value('./@ItemId','int')
,myXML.value('./@UId','int'),
myXML.value('./@Rate','decimal(18,2)'),
myXML.value('./@Qty', 'decimal (18,2)'),
myXML.value('./@POId', 'decimal (18,2)'),
myXML.value('./@TotalPackage','decimal (18,2)'),
myXML.value('./@PcsPerPackage','decimal (18,2)'),
myXML.value('./@RatePerPackage','decimal (18,2)'),
myXML.value('./@PackageId','int'),
myXML.value('./@GRNId','int'),
myXML.value('./@DSCOId','int'),
myXML.value('./@DiscountPerPcs','decimal (18,2)'),
myXML.value('./@TaxPerPcs','decimal (18,2)'),
myXML.value('./@TaxType','nvarchar(50)'),
myXML.value('./@NetAmount','decimal (18,2)'),
myXML.value('./@Amount','decimal (18,2)'),
myXML.value('./@TaxMode','int')

		
    FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;

End
COMMIT

Insert into Warehouse_Store
(
PRId,Date,ItemId,Unit,Qty,Rate,[Type],SId,BRId
)
Select
 @PRId,@Date, myXML.value('./@ItemId','int'),myXML.value('./@UId', 'int')
, myXML.value('./@Qty', 'decimal(18,2)')
-- / myXML.value('./@Factor', 'decimal(18,2)')
, myXML.value('./@Rate', 'decimal(18,2)')
-- * myXML.value('./@Factor', 'decimal(18,2)')
,'Out',@SId,@BRId

    FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;


END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
EXECUTE [uspGetErrorInfo]
END CATCH

select @PRId