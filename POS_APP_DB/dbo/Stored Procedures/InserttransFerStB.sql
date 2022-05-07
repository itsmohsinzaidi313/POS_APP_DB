

CREATE proc [dbo].[InserttransFerStB]--'7/31/2013','TR-0001','10','1','1','1500','<doc><title ItemId="38" UId="19" Qty="10" Rate="150" TotalPackage="0" PcsPerPackage="0" RatePerPackage="0" Amount="1500"  PackageId="19" /></doc>'

@Date as datetime,
@TRNo as nvarchar(50),
@UserId as int,
@TRInId as  int,
@TROutId as  int,
@TotalAmount as decimal(18,2),
@From as nvarchar(50),
@To as nvarchar(50),
@XML as xml

as
BEGIN TRY
   BEGIN TRANSACTION 
DECLARE @TransferId int;
DECLARE @TRId int;
DECLARE @TRIId int;

Insert into Transfer
(
Date ,
TRNo,
UserId ,
TotalAmount,
[From],
[To] 
)
values
(
@Date ,
@TRNo,
@UserId ,
@TotalAmount,
@From ,
@To 

)

SET @TransferId = SCOPE_IDENTITY();

if @TransferId > 0
Begin

Insert into TransferOutMaster
(
TransferId,
TROutId

)

values
(
@TransferId,
@TROutId

)

SET @TRId = SCOPE_IDENTITY();
if @TRId > 0
Begin
Insert into TransferOutDetail
(
TRId,
ItemId,
Unit,
QTY ,
Rate,
--TotalPackage,
--PcsPerPackage,
--RatePerPackage,
PackageId

)
SELECT 
@TRId,


 myXML.value('./@ItemId','int')
,myXML.value('./@UId','int'),
myXML.value('./@Qty', 'decimal (18,2)'),
myXML.value('./@Rate','decimal(18,2)'),
--myXML.value('./@TotalPackage','decimal (18,2)'),
--myXML.value('./@PcsPerPackage','decimal (18,2)'),
--myXML.value('./@RatePerPackage','decimal (18,2)'),
myXML.value('./@PackageId','int')

		
    FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;
End
End
COMMIT

Insert into Warehouse_Store
(
Date,ItemId,Unit,Qty,Rate,[Type],TROutId,SId
)
Select
@Date, myXML.value('./@ItemId','int'),myXML.value('./@PurUnitId', 'int')
, myXML.value('./@Qty', 'decimal(18,2)')
 / myXML.value('./@Factor', 'decimal(18,2)')
, myXML.value('./@Rate', 'decimal(18,2)')
 * myXML.value('./@Factor', 'decimal(18,2)')
,'Out',@TRId,@TROutId


    FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;

Insert into TransferInMaster
(
TransferId,
TRInId

)

values
(
@TransferId,
@TRInId
)

SET @TRIId = SCOPE_IDENTITY();
if @TRIId > 0
Begin
Insert into TransferInDetail
(
TRIId,
ItemId,
Unit,
QTY ,
Rate,
--TotalPackage,
--PcsPerPackage,
--RatePerPackage,
PackageId

)
SELECT 
@TRIId,


 myXML.value('./@ItemId','int')
,myXML.value('./@UId','int'),
myXML.value('./@Qty', 'decimal (18,2)'),
myXML.value('./@Rate','decimal(18,2)'),
--myXML.value('./@TotalPackage','decimal (18,2)'),
--myXML.value('./@PcsPerPackage','decimal (18,2)'),
--myXML.value('./@RatePerPackage','decimal (18,2)'),
myXML.value('./@PackageId','int')

		
    FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;

End

Insert into WareHouse_Branch
(
Date,ItemId,Unit,Qty,Rate,[Type],TRInId,BRId,SId
)
Select
@Date, myXML.value('./@ItemId','int'),myXML.value('./@UId', 'int')
, myXML.value('./@Qty', 'decimal(18,2)')
-- / myXML.value('./@Factor', 'decimal(18,2)')
, myXML.value('./@Rate', 'decimal(18,2)')
-- * myXML.value('./@Factor', 'decimal(18,2)')
,'In',@TRIId,@TRInId,@TROutId

    FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
EXECUTE [uspGetErrorInfo]
END CATCH

select @TransferId







