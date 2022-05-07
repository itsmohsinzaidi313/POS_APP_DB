

CREATE Proc [dbo].[InsertCustomerSaleInvoice]--'11/28/13 12:00 AM','28','GRN-0001','134','0','21.4','0','21.4','<doc><title ItemId="72" Unit="19" Qty="10" Rate="2.14" TotalPackage="0" PcsPerPackage="0" RatePerPackage="0" Amount="21.40" POId="" PackageId="19" Type="Kg" Tax="Kg" Discount="Kg" ActualRate="2" /></doc>','11'
@Date as datetime,
@CustId as int,
@SaleInvoiceNo as nvarchar(50),
@SID as int,
@BRId as int,
@Amount as decimal(18,2),
@Discount as decimal(18,2),
@TotalAmount as decimal(18,2),
@XML as xml,
@RefrenceNo as nvarchar(50),
@Tax as decimal(18,2),
@COId as int
as
BEGIN TRY
   BEGIN TRANSACTION  

Declare @SLId as  int;
set @SLId=0;

insert into CustomerSaleInvoiceMaster
(Date,CustId,SaleInvoiceNo,SId,BRId,Amount,Discount,TotalAmount,RefrenceNo,TotalTax)
values 
(@Date,@CustId,@SaleInvoiceNo,@SID ,@BRId ,@Amount ,@Discount ,@TotalAmount,@RefrenceNo,@Tax)

set @SLId = SCOPE_IDENTITY();

if @SLId > 0
Begin
Insert into CustomerSaleInvoiceDetail
(
SLId,ItemId,Unit,Qty,Rate,TotalPackage,PcsPerPackage,RatePerPackage,PackageId,Tax,Discount,Amount,ActualRate,TaxType
)
SELECT 
@SLId
,myXML.value('./@ItemId','int')
,myXML.value('./@Unit','int'),
myXML.value('./@Qty', 'decimal (18,2)'),
--myXML.value('./@POId', 'int'),
myXML.value('./@Rate','decimal(18,2)'),
myXML.value('./@TotalPackage','decimal (18,2)'),
myXML.value('./@PcsPerPackage','decimal (18,2)'),
myXML.value('./@RatePerPackage','decimal (18,2)'),
myXML.value('./@PackageId','int'),
myXML.value('./@Tax','decimal (18,2)'),
myXML.value('./@Discount','decimal (18,2)'),
myXML.value('./@Amount','decimal (18,2)'),
myXML.value('./@ActualRate','decimal (18,2)'),
myXML.value('./@TaxType','nvarchar(50)')

		
FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;
end
   COMMIT

insert into Warehouse_store (date,ItemId,Unit,Qty,Rate,[Type],SId,[Desc],Amount,SLId)
select
@Date,myXML.value('./@ItemId','int')
,myXML.value('./@Unit','int'),myXML.value('./@Qty', 'decimal (18,2)'),myXML.value('./@Rate','decimal(18,2)'),'Out',
@SID,'Customer Sale',(myXML.value('./@Qty', 'decimal (18,2)') * myXML.value('./@Rate','decimal(18,2)')),@SLId

FROM @XML.nodes('/doc/title') As nodes(myXML);
    SET NOCOUNT OFF;

EXECUTE [uspInsertCustomerLedger] @SLId,@TotalAmount,'C',@CustId,@Date,@COId,'SALE VOUCHER',@SaleInvoiceNo,@SLId

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
exec uspGetErrorInfo
--set @GRNId=0;
END CATCH
select @SLId;
