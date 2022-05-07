CREATE proc [dbo].[uspInsertOpenInventory]
@Date as datetime,
@SId as int,
@XML as xml
as
BEGIN TRY
   BEGIN TRANSACTION  

Declare @OpenInvId int;
set @OpenInvId = 0;

insert into OpenInventoryMaster (Date) values (@Date) 
set @OpenInvId = scope_identity();

if @OpenInvId > 0
Begin

INSERT INTO OpenInventoryDetail
    (
OpenInvId,
ItemId,
Unit,
Qty,
Rate,
Amount
    )
SELECT 
@OpenInvId,
          myXML.value('./@ItemId', 'int'),
 myXML.value('./@Unit', 'int')
         , myXML.value('./@Qty', 'decimal(18,2)')
         , myXML.value('./@Rate', 'decimal(18,2)')
         , myXML.value('./@Amount', 'decimal(18,2)')
    FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;

End

COMMIT

INSERT INTO Warehouse_Store
    (
		Date,ItemId,Unit,Qty,Rate,[Type],SId,[Desc],Amount,OpenInvId
    )
SELECT 
@Date,
myXML.value('./@ItemId', 'int'),
myXML.value('./@Unit', 'int'),
myXML.value('./@Qty', 'decimal(18,2)'),
myXML.value('./@Rate', 'decimal(18,2)'),
'In',@SId,'Open',
myXML.value('./@Amount', 'decimal(18,2)'),
@OpenInvId

FROM @XML.nodes('/doc/title') As nodes(myXML);
    SET NOCOUNT OFF;

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
EXECUTE [uspGetErrorInfo]
END CATCH
select @OpenInvId;