CREATE Proc [dbo].[InsertPurchaseReturnNew]--'11/28/13 12:00 AM','28','GRN-0001','134','0','21.4','0','21.4','<doc><title ItemId="72" Unit="19" Qty="10" Rate="2.14" TotalPackage="0" PcsPerPackage="0" RatePerPackage="0" Amount="21.40" POId="" PackageId="19" Type="Kg" Tax="Kg" Discount="Kg" ActualRate="2" /></doc>','11'
@Date as datetime,
@VId as int,
@GRNId as int,
@PRNo as nvarchar(50),
@SID as int,
@BRId as int,
@Amount as decimal(18,2),
@Discount as decimal(18,2),
@TotalAmount as decimal(18,2),
@XML as xml,
@RefrenceNo as nvarchar(50),
@Tax as decimal(18,2)
as
BEGIN TRY
   BEGIN TRANSACTION  

Declare @PRId as  int;
set @PRId=0;

insert into PurchaseReturnMasterNew
(Date,VId,GRNId,PRNo,SId,BRId,Amount,Discount,TotalAmount,RefrenceNo,TotalTax)
values 
(@Date,@VId,@GRNId,@PRNo,@SID ,@BRId ,@Amount ,@Discount ,@TotalAmount,@RefrenceNo,@Tax)

set @PRId = SCOPE_IDENTITY();

if @PRId > 0
Begin
Insert into PurchaseReturnDetailNew
(
PRId,ItemId,Unit,Qty,POId,Rate,TotalPackage,PcsPerPackage,RatePerPackage,PackageId,Tax,Discount,Amount,ActualRate,TaxType
)
SELECT 
@PRId
,myXML.value('./@ItemId','int')
,myXML.value('./@Unit','int'),
myXML.value('./@Qty', 'decimal (18,2)'),
myXML.value('./@POId', 'int'),
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

Insert into Warehouse_Store
(
PRId,Date,ItemId,Unit,Qty,Rate,[Type],SId,BRId,Amount
)
Select
 @PRId,@Date, myXML.value('./@ItemId','int'),myXML.value('./@UId', 'int')
, myXML.value('./@Qty', 'decimal(18,2)')
-- / myXML.value('./@Factor', 'decimal(18,2)')
, myXML.value('./@Rate', 'decimal(18,2)')
-- * myXML.value('./@Factor', 'decimal(18,2)')
,'Out',@SId,@BRId,(myXML.value('./@Qty', 'decimal(18,2)') * myXML.value('./@Rate', 'decimal(18,2)'))

    FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;



END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
exec uspGetErrorInfo
--set @GRNId=0;
END CATCH
select @PRId;
