
CREATE Proc [dbo].[InsertGoodReceiving]--'11/28/13 12:00 AM','28','GRN-0001','134','0','21.4','0','21.4','<doc><title ItemId="72" Unit="19" Qty="10" Rate="2.14" TotalPackage="0" PcsPerPackage="0" RatePerPackage="0" Amount="21.40" POId="" PackageId="19" Type="Kg" Tax="Kg" Discount="Kg" ActualRate="2" /></doc>','11'
@Date as datetime,
@VId as int,
@GRNNo as nvarchar(50),
@SID as int,
@BRId as int,
@Amount as decimal(18,2),
@Discount as decimal(18,2),
@TotalAmount as decimal(18,2),
@XML as xml,
@RefrenceNo as nvarchar(50),
@Tax as decimal(18,2),
@Desc as nvarchar(max)
as
BEGIN TRY
   BEGIN TRANSACTION  

Declare @GRNId as  int;
set @GRNId=0;

insert into GRNMaster
(Date,VId,GRNo,SId,BRId,Amount,Discount,TotalAmount,RefrenceNo,TotalTax,[Desc])
values 
(@Date,@VId,@GRNNo,@SID ,@BRId ,@Amount ,@Discount ,@TotalAmount,@RefrenceNo,@Tax,@Desc)

set @GRNId = SCOPE_IDENTITY();

if @GRNId > 0
Begin
Insert into GRNDetail
(
GRNId,ItemId,Unit,Qty,POId,Rate,TotalPackage,PcsPerPackage,RatePerPackage,PackageId,Tax,Discount,Amount,ActualRate,TaxType
)
SELECT 
@GRNId
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

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
exec uspGetErrorInfo
--set @GRNId=0;
END CATCH
select @GRNId;

