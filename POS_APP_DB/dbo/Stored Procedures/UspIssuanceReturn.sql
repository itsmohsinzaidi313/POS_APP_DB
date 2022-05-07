
CREATE proc [dbo].[UspIssuanceReturn]--'32','7/25/2013','85','10','ISSR-0001','<doc><title ItemId="34" UId="21" Rate="15.00" Qty="10" Amount="150.00" /></doc>'

@BRId as int,
@Date as datetime,
@SId as int,
@UserId as int,
@IssRNo as nvarchar(50),
--@DSId as int,
@XML as xml,
@DId as int
as
BEGIN TRY
   BEGIN TRANSACTION 
DECLARE @IssRTId int;

Insert into IssuanceReturnMaster
(
BRId,
Date,
SId,
UserId ,
IssRNo 
--DSId
,DId
)
values
(
@BRId,
@Date,
@SId,
@UserId ,
@IssRNo 
--@DSId
,@DId
)

SET @IssRTId = SCOPE_IDENTITY();

if @IssRTId > 0
Begin
Insert into IssuanceReaturnDetail
(
IssRTId,
ItemId,
Unit,
Rate,
QTY ,
Amount 

)
SELECT 
@IssRTId,


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
IssRTId,Date,ItemId,Unit,Qty,Rate,[Type],SId,BRId,DId,Amount
)
Select
 @IssRTId,@Date, myXML.value('./@ItemId','int'),myXML.value('./@PurUnitId', 'int')
, myXML.value('./@Qty', 'decimal(18,2)')
 / myXML.value('./@Factor', 'decimal(18,2)'), myXML.value('./@Rate', 'decimal(18,2)') * myXML.value('./@Factor', 'decimal(18,2)')
,'In',@SId,@BRId,@DId

, (myXML.value('./@Qty', 'decimal(18,2)')
 / myXML.value('./@Factor', 'decimal(18,2)')) * (myXML.value('./@Rate', 'decimal(18,2)') * myXML.value('./@Factor', 'decimal(18,2)'))


    FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;

Insert into Warehouse_Branch
(IssRTId,Date,ItemId,Unit,Qty,Rate,[Type],SId,BRId,DId,Amount)
Select @IssRTId,@Date,myXML.value('./@ItemId', 'int')
,myXML.value('./@UId', 'int')
, myXML.value('./@Qty', 'decimal(18,2)'),
 myXML.value('./@Rate', 'decimal(18,2)'),'Out',@SId,@BRId,@DId
, myXML.value('./@Qty', 'decimal(18,2)') * 
 myXML.value('./@Rate', 'decimal(18,2)')
    FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;


END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
EXECUTE [uspGetErrorInfo]
END CATCH

select @IssRTId
