CREATE Proc [dbo].[InsertInvoiceCompany]
@Date as datetime,
@COID as int,
@UserId as int,
@VId as int,
@InvoiceNo as nvarchar(50),
@SId as  int,
@BRId as  int,
@Amount as decimal(18,2),
@Discount as decimal(18,2),
@TotalAmount as decimal(18,2),
@XML as xml,
@GRNID as int,
@RefrenceNo as nvarchar(50),
@TotalTax as decimal(18,2)

as
BEGIN TRY
   BEGIN TRANSACTION  

Declare @InvoiceId as  int;
set @InvoiceId=0;
Declare @Master as nvarchar(max);
Set @Master='InvoiceMaster_Company';
Declare @Detail as nvarchar(max)
Set @Detail ='InvoiceDetail_Company';


Declare @ParamDefination1 as  nvarchar(max);
declare @SQLString1 as nvarchar(max);
SET @SQLString1='Insert Into '+@Master+' (Date,COId,UserId,VId,InvoiceNo,Sid,BRId,Amount,Discount,TotalAmount,GRNId,RefrenceNo,TotalTax) values
(''' + CONVERT(VARCHAR(10),@Date, 101) + ''',''' + CONVERT(VARCHAR(10),@COID, 101) + ''',
''' + CONVERT(VARCHAR(10),@UserId, 101) + ''',''' + CONVERT(VARCHAR(10),@VId, 101) + '''
,''' + CONVERT(VARCHAR(10),@InvoiceNo, 101) + ''',''' + CONVERT(VARCHAR(10),@SId, 101) + ''',''' + CONVERT(VARCHAR(10),@BRId, 101) + ''',''' + CONVERT(VARCHAR(10),@Amount, 101) + ''',''' + CONVERT(VARCHAR(10),@Discount, 101) + ''',''' + CONVERT(VARCHAR(10),@TotalAmount, 101) + ''',''' + CONVERT(VARCHAR(10),@GRNId, 101) + ''',''' + CONVERT(VARCHAR(10),@RefrenceNo, 101) + ''',''' + CONVERT(VARCHAR(10),@TotalTax, 101) + ''')
  Select @InvoiceId = Scope_Identity()'
Set @ParamDefination1=N'@InvoiceId int OUTPUT'
exec sp_executesql @SQLString1,@ParamDefination1,@InvoiceId=@InvoiceId OUTPUT
COMMIT
if @InvoiceId > 0
begin
declare @SQLString2 as nvarchar(max);
Declare @ParamDefination2 as  nvarchar(max);
SET @SQLString2='Insert Into '+@Detail+' (InvoiceId,ItemId,Unit,Rate,Qty,POId,DiscountPerPcs,TaxPerPcs,TotalPackage,PcsPerPackage,RatePerPackage,PackageId,TaxType,NetAmount,Amount,TaxMode) 
SELECT 
''' + CONVERT(VARCHAR(10),@InvoiceId, 101) + ''',
myXML.value(''./@ItemId'',''int''),
myXML.value(''./@Unit'',''nvarchar(50)''),
myXML.value(''./@Rate'', ''decimal (18,2)''),
myXML.value(''./@Qty'', ''decimal (18,2)''),myXML.value(''./@POId'', ''int'')
,myXML.value(''./@DiscountPerPcs'', ''decimal (18,2)'')
,myXML.value(''./@TaxPerPcs'', ''decimal (18,2)'')
,myXML.value(''./@TotalPackage'', ''decimal (18,2)'')
,myXML.value(''./@PcsPerPackage'', ''decimal (18,2)'')
,myXML.value(''./@RatePerPackage'', ''decimal (18,2)'')
,myXML.value(''./@PackageId'', ''int'')
,myXML.value(''./@TaxType'', ''nvarchar(50)'')
,myXML.value(''./@NetAmount'', ''decimal (18,2)'')
,myXML.value(''./@Amount'', ''decimal (18,2)'')
,myXML.value(''./@TaxMode'', ''int'')
FROM @XML.nodes(''/doc/title'') As nodes(myXML)'
Set @ParamDefination2=N'@XML xml OUTPUT'
exec sp_executesql @SQLString2,@ParamDefination2,@XML=@XML OUTPUT
    SET NOCOUNT OFF;
end


--TempTableWork
DECLARE @TEMPNEWMAP TABLE
(
	TransId  int null,
	[Type] nvarchar(10),
	VN  nvarchar(10),
	Date datetime,
	AccId nvarchar(50),
	AccType nvarchar(50),
	Amount decimal (18,2) null,
	Account nvarchar(50),
	DetailId int null,
    CAId int null,
	COId int null

)
--
Declare @TaxType as nvarchar(50);
Declare @MapId as int;
--set @COId = 0;
set @MapId = 0;
--select @COId = COId from Company where IsSelected = 1
Select @MapId = id from DiscountMapping where [Transaction] = 'STOCK'
if @MapId >0
begin 
--Select @TaxType= TaxType from InvoiceDetail_Company
Insert into @TEMPNEWMAP (TransId,[Type],VN,Date,AccId,AccType,Amount,Account,DetailId,CAId,COId)
Select '0',dm.[TYPE],@InvoiceNo,@Date,ca.AccNo,ca.AccNature,@TotalAmount,ca.AccName,@InvoiceId,dm.CAId,ca.COId
from DiscountMapping dm
inner Join ChartOfAccount ca on ca.CAId=dm.CAId
where [Transaction]='STOCK'


Insert into @TEMPNEWMAP (TransId,[Type],VN,Date,AccId,AccType,Amount,Account,DetailId,CAId,COId)
select '0','C',@InvoiceNo,@Date,ca.AccNo,ca.AccNature,@TotalAmount,ca.AccName,@InvoiceId,v.CAId,ca.COId 
from Vendor v inner join InvoiceMaster_Company icm on
v.VId = icm.VId
inner Join ChartOfAccount ca on v.CAId=ca.CAId
group by v.CAId,ca.AccNo,ca.AccNature,ca.AccName,ca.COId

end

set @MapId = 0;
Select @MapId = id from DiscountMapping where [Transaction] = 'TAX'
if @MapId >0
begin 

Insert into @TEMPNEWMAP (TransId,[Type],VN,Date,AccId,AccType,Amount,Account,DetailId,CAId,COId)

Select '0',dm.[TYPE],@InvoiceNo,@Date,ca.AccNo,ca.AccNature,@TotalTax,ca.AccName,@InvoiceId,dm.CAId,ca.COId
from DiscountMapping dm
inner Join ChartOfAccount ca on ca.CAId=dm.CAId
where [Transaction]='TAX'


Insert into @TEMPNEWMAP (TransId,[Type],VN,Date,AccId,AccType,Amount,Account,DetailId,CAId,COId)

select '0','C',@InvoiceNo,@Date,ca.AccNo,ca.AccNature,@TotalTax,ca.AccName,@InvoiceId,tx.CAId,ca.COId from Tax_ tx
inner Join ChartOfAccount ca on tx.CAId=ca.CAId
where tx.[Type]=@TaxType
group by tx.CAId,ca.AccNo,ca.AccNature,ca.AccName,ca.COId

end

set @MapId = 0;
Select @MapId = id from DiscountMapping where [Transaction] = 'DISCOUNT'
if @MapId >0
begin 

Insert into @TEMPNEWMAP (TransId,[Type],VN,Date,AccId,AccType,Amount,Account,DetailId,CAId,COId)

Select '0',dm.[TYPE],@InvoiceNo,@Date,ca.AccNo,ca.AccNature,@Discount,ca.AccName,@InvoiceId,dm.CAId,ca.COId
from DiscountMapping dm
inner Join ChartOfAccount ca on ca.CAId=dm.CAId
where [Transaction]='DISCOUNT'
end

--
--
----select * from @TEMPNEWMAP
----EndTempTableWork
insert into GL
(
[Type],
VN,
VoucherId,
Date,
Amount,
CAId,
VoucherType,
COId,
APId
)
select
	[Type] ,
	VN ,
	DetailId,
	Date ,
	Amount ,
	CAId,
	'PURCHASE',
	COId,
	0 
	
from @TEMPNEWMAP



END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
--exec uspGetErrorInfo
set @InvoiceId=0;
END CATCH
select @InvoiceId;
