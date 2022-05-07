

Create proc [dbo].[InsertButcheryIssuance]

@BRId as int,
@Date as datetime,
@SId as int,
@UserId as int,
@IssBNo as nvarchar(50)
,@XML as xml

as
BEGIN TRY
   BEGIN TRANSACTION 
DECLARE @BUTId int;

Insert into IssuanceButcheryMaster
(
BRId ,
Date ,
SId ,
UserId ,
IssBNo 

)
values
(
@BRId ,
@Date ,
@SId ,
@UserId ,
@IssBNo 
)

SET @BUTId = SCOPE_IDENTITY();

if @BUTId > 0
Begin

Insert into IssuanceButcheryDetail
(
BUTId,
ItemId,
Unit,
Rate,
QTY ,
Amount

)

SELECT 
@BUTId,


 myXML.value('./@ItemId','int')
,myXML.value('./@UId','int'),
myXML.value('./@Rate','decimal(18,2)'),
myXML.value('./@Qty', 'decimal (18,2)'),
myXML.value('./@Amount', 'decimal (18,2)')

		
    FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;

End
COMMIT

Insert into Warehouse_Store
(
BUTId,Date,ItemId,Unit,Qty,Rate,[Type],SId,BRId
)
Select
 @BUTId,@Date, myXML.value('./@ItemId','int'),myXML.value('./@UId', 'int')
, myXML.value('./@Qty', 'decimal(18,2)')
/ myXML.value('./@Factor', 'decimal(18,2)')
, myXML.value('./@Rate', 'decimal(18,2)')
 * myXML.value('./@Factor', 'decimal(18,2)')
,'Out',@SId,@BRId

    FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;


END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
EXECUTE [uspGetErrorInfo]
END CATCH

select @BUTId



