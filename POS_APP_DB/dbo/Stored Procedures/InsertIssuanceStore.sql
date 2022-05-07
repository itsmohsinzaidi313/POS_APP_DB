

CREATE Proc [dbo].[InsertIssuanceStore]--'51','05/20/14 12:00 AM','146','0','ISS','ISS-0001','92','<doc><title ItemId="104" UId="28" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="105" UId="19" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="101" UId="19" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="106" UId="28" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="107" UId="19" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="108" UId="30" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="109" UId="31" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="110" UId="24" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="111" UId="19" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="112" UId="19" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="125" UId="36" Rate="0.00" Qty="1.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="113" UId="43" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="114" UId="19" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="115" UId="19" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="103" UId="31" Rate="0.00" Qty="8.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="116" UId="28" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="102" UId="27" Rate="0.00" Qty="1.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="117" UId="19" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="118" UId="19" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="119" UId="28" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="122" UId="36" Rate="0.00" Qty="1.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="120" UId="19" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /><title ItemId="121" UId="19" Rate="0.00" Qty="10.00" Amount="0.0000" Factor="" PurUnitId="" DSId="92" /></doc>','17'
@BRId as int,
@Date as datetime,
@SId as int,
@UserId as int,
@Type as nvarchar(50),
@IssNo as nvarchar(50),
@DSId as int
,@XML as xml
,@DId as int,
@Desc as nvarchar(max)
as
BEGIN TRY
   BEGIN TRANSACTION  

Declare @IssId as  int;
set @IssId=0;
Declare @Master as nvarchar(max);
Set @Master='IssuanceMaster_Store';
Declare @Detail as nvarchar(max)
Set @Detail ='IssuanceDetail_Store';

if @IssNo <> '0'
begin 
Declare @ParamDefination1 as  nvarchar(max);
declare @SQLString1 as nvarchar(max);
declare @GRNId as int;
set @GRNId = 0;
select @GRNId = isnull(max(GRNId),0) from GRNMaster
SET @SQLString1='Insert Into '+@Master+' (Date,Sid,BRId,UserId,Type,IssNo,DSId,DId,GRNId,[Desc]) 
values(''' + CONVERT(VARCHAR(10),@Date, 101) + ''',''' + CONVERT(VARCHAR(10),@SId, 101) + ''',''' + CONVERT(VARCHAR(10),@BRId, 101) + ''',
 ''' + CONVERT(VARCHAR(10),@UserId, 101) + ''',''' + CONVERT(VARCHAR(10),@Type,101) + ''',''' + CONVERT(VARCHAR(10),@IssNo,101) + ''',''' + CONVERT(VARCHAR(10),@DSId, 101) + ''',''' + CONVERT(VARCHAR(10),@DId, 101) + '''
,''' + CONVERT(VARCHAR(10),@GRNId,101) + ''',''' + @Desc + ''')
  Select @IssId = Scope_Identity()'
Set @ParamDefination1=N'@IssId int OUTPUT'
exec sp_executesql @SQLString1,@ParamDefination1,@IssId=@IssId OUTPUT
if @IssId > 0
begin
declare @SQLString2 as nvarchar(max);
Declare @ParamDefination2 as  nvarchar(max);
SET @SQLString2='Insert Into '+@Detail+' (IssId,ItemId,Unit,Rate,Qty,Amount,DSId) 
SELECT 
''' + CONVERT(VARCHAR(10),@IssId, 101) + ''',
 myXML.value(''./@ItemId'',''int''),myXML.value(''./@UId'',''int''),myXML.value(''./@Rate'',''decimal(18,3)''),
myXML.value(''./@Qty'', ''decimal (18,2)''),myXML.value(''./@Amount'', ''decimal (18,2)''),myXML.value(''./@DSId'',''int'') 
FROM @XML.nodes(''/doc/title'') As nodes(myXML)'
Set @ParamDefination2=N'@XML xml OUTPUT'
exec sp_executesql @SQLString2,@ParamDefination2,@XML=@XML OUTPUT

    SET NOCOUNT OFF;
end

--insert into Warehouse_Store (IssId,Date,ItemId,Unit,Qty,Rate,[Type],SId,BRId)  
--Select @IssId,@Date,myXML.value('./@ItemId', 'int'),myXML.value('./@UId', 'int')
--, myXML.value('./@Qty', 'decimal(18,3)'), myXML.value('./@Rate', 'decimal(18,3)'),'Out',@SId,@BRId
--
--		
--    FROM @XML.nodes('/doc/title') As nodes(myXML);
---- <doc><title
--    SET NOCOUNT OFF;


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

Declare @TotalAmount as decimal(18,3);
set @TotalAmount = 0;
Declare @MapId as int;
set @MapId = 0;
Declare @COGID as int;
set @COGID = 0;

select @TotalAmount = isnull(sum(Amount),0) from IssuanceDetail_Store where IssId = @IssId

Select @MapId = isnull(id,0) from DiscountMapping where [Transaction] = 'STOCK STORE' and Form = 'ISSUANCE'
Select @COGID = isnull(CAId,0) from ChartOfAccount where AccName = 'COST OF GOODS SOLD' 

if @MapId >0
begin 

Insert into @TEMPNEWMAP (TransId,[Type],VN,Date,AccId,AccType,Amount,Account,DetailId,CAId,COId)
Select 0,dm.[TYPE],@IssNo,@Date,ca.AccNo,ca.AccNature,@TotalAmount,ca.AccName,@IssId,dm.CAId,ca.COId
from DiscountMapping dm
inner Join ChartOfAccount ca on ca.CAId=dm.CAId
where dm.[Transaction] = 'STOCK STORE' and dm.Form = 'ISSUANCE'

end

set @MapId = 0;
Select @MapId = isnull(id,0) from DiscountMapping where [Transaction] = 'STOCK KITCHEN' and Form = 'ISSUANCE'
if @MapId > 0
begin 

Insert into @TEMPNEWMAP (TransId,[Type],VN,Date,AccId,AccType,Amount,Account,DetailId,CAId,COId)
Select 0,dm.[TYPE],@IssNo,@Date,ca.AccNo,ca.AccNature,@TotalAmount,ca.AccName,@IssId,dm.CAId,ca.COId
from DiscountMapping dm
inner Join ChartOfAccount ca on ca.CAId=dm.CAId
where dm.[Transaction] = 'STOCK KITCHEN' and dm.Form = 'ISSUANCE'

Insert into @TEMPNEWMAP (TransId,[Type],VN,Date,AccId,AccType,Amount,Account,DetailId,CAId,COId)
Select 0,'C',@IssNo,@Date,ca.AccNo,ca.AccNature,@TotalAmount,ca.AccName,@IssId,dm.CAId,ca.COId
from DiscountMapping dm
inner Join ChartOfAccount ca on ca.CAId=dm.CAId
where dm.[Transaction] = 'STOCK KITCHEN 2' and dm.[Type] = 'C' 

Insert into @TEMPNEWMAP (TransId,[Type],VN,Date,AccId,AccType,Amount,Account,DetailId,CAId,COId)
SELECT 0,'D',@IssNo,@Date,ca.AccNo,ca.AccNature,@TotalAmount,ca.AccName,@IssId,dm.CAId,ca.COId
from DiscountMapping dm

inner Join ChartOfAccount ca on ca.CAId=dm.CAId
where dm.[Transaction] = 'COST OF GOODS SOLD' and dm.Form = 'ISSUANCE'


end


insert into Warehouse_Store (IssId,Date,ItemId,Unit,Qty,Rate,[Type],SId,BRId,DId,Amount)  
Select @IssId,@Date,myXML.value('./@ItemId', 'int'),myXML.value('./@PurUnitId', 'int')
, (myXML.value('./@Qty', 'decimal(18,3)') / myXML.value('./@Factor', 'decimal(18,3)'))
, (myXML.value('./@Rate', 'decimal(18,3)') * myXML.value('./@Factor', 'decimal(18,3)'))
,'Out',@SId,@BRId,@DId
,((myXML.value('./@Qty', 'decimal(18,3)') / myXML.value('./@Factor', 'decimal(18,3)'))
* (myXML.value('./@Rate', 'decimal(18,3)') * myXML.value('./@Factor', 'decimal(18,3)')))
		
    FROM @XML.nodes('/doc/title') As nodes(myXML);
-- <doc><title
    SET NOCOUNT OFF;


end

   COMMIT

insert into Warehouse_Branch (IssId,Date,ItemId,Unit,Qty,Rate,[Type],SId,BRId,DId,Amount)    
Select @IssId,@Date,myXML.value('./@ItemId', 'int'),myXML.value('./@UId', 'int')
, myXML.value('./@Qty', 'decimal(18,3)'), myXML.value('./@Rate', 'decimal(18,3)'),'In',@SId,@BRId,@DId
, myXML.value('./@Qty', 'decimal(18,3)') * myXML.value('./@Rate', 'decimal(18,3)')
		
    FROM @XML.nodes('/doc/title') As nodes(myXML);
-- <doc><title
    SET NOCOUNT OFF;

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
	'ISSUANCE',
	COId,
	0 
	
from @TEMPNEWMAP


END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
exec uspGetErrorInfo
Select '0',@IssNo,@Date,@TotalAmount,@IssId,@MapId

set @IssId = 0;
END CATCH
select @IssId


--select * from DiscountMapping
--select * from ChartOfAccount






