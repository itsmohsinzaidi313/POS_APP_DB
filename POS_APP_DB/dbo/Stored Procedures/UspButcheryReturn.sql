


CREATE proc [dbo].[UspButcheryReturn]--'09/09/2013','115','14','10','BUR-0005','<doc><title ItemId="46" UId="19" Rate="95.00" Qty="40" WesQty="10.00" Amount="3800.00" Factor="1.00" PurUnitId="19" /></doc>'

@Date as datetime,
@SId as int,
@BUTId as int,
@UserId as int,
@BURNo as nvarchar(50)
,@XML as xml
as
BEGIN TRY
   BEGIN TRANSACTION 
DECLARE @BUTRId int;

Insert into ButcheryReturnMaster
(

Date,
SId,
BUTId,
UserId ,
BURNo

)
values
(

@Date,
@SId,
@BUTId,
@UserId ,
@BURNo
)

SET @BUTRId = SCOPE_IDENTITY();

if @BUTRId > 0
Begin
Insert into ButcheryReturnDetail
(
BUTRId,
ItemId,
Unit,
Rate,
QTY ,
WesQty,
Amount ,
RawItemId

)
SELECT 
@BUTRId,


 myXML.value('./@ItemId','int')
,myXML.value('./@UId','int'),
myXML.value('./@Rate','decimal(18,2)'),
--'0',
myXML.value('./@Qty', 'decimal (18,2)'),
myXML.value('./@WesQty', 'decimal (18,2)'),
myXML.value('./@Amount', 'decimal (18,2)'),
myXML.value('./@RawItemId', 'int')

		
    FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;

End
COMMIT

Insert into Warehouse_Store
(
BUTRId,Date,ItemId,Unit,Qty,WesQty,Rate,[Type],SId,Amount
)
Select
 @BUTRId,@Date, myXML.value('./@ItemId','int'),myXML.value('./@PurUnitId', 'int')
, myXML.value('./@Qty', 'decimal(18,2)')
 / myXML.value('./@Factor', 'decimal(18,2)'),
myXML.value('./@WesQty', 'decimal (18,2)'),
 myXML.value('./@Rate', 'decimal(18,2)') * myXML.value('./@Factor', 'decimal(18,2)'),
'In',@SId,myXML.value('./@Amount', 'decimal (18,2)')

    FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;

--Insert into Warehouse_Branch
--(IssRTId,Date,ItemId,Unit,Qty,Rate,[Type],SId,BRId)
--Select @IssRTId,@Date,myXML.value('./@ItemId', 'int')
--,myXML.value('./@UId', 'int')
--, myXML.value('./@Qty', 'decimal(18,2)'),
-- myXML.value('./@Rate', 'decimal(18,2)'),'Out',@SId,@BRId
--
--    FROM @XML.nodes('/doc/title') As nodes(myXML);
-- 
--    SET NOCOUNT OFF;

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
EXECUTE [uspGetErrorInfo]
END CATCH

select @BUTRId
