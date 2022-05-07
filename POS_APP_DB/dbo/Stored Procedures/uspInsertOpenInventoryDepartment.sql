


CREATE proc [dbo].[uspInsertOpenInventoryDepartment]--'07/01/14 12:00 AM',146,51,31,'<doc><title ItemId="133" Unit="46" Qty="1000.00" Rate="0.00" Amount="0.0000" /><title ItemId="135" Unit="50" Qty="1050.00" Rate="0.00" Amount="0.0000" /><title ItemId="136" Unit="51" Qty="0.00" Rate="1.00" Amount="0.0000" /><title ItemId="134" Unit="49" Qty="0.00" Rate="0.00" Amount="0.0000" /></doc>'
@Date as datetime,
@SId as int,
@BRId as int,
@Did as int,
@XML as xml
as
BEGIN TRY
   BEGIN TRANSACTION  

Declare @OpenInvId int;
insert into OpenInventoryMaster_Department (Date,Did) values (@Date,@Did) 
set @OpenInvId = scope_identity();
if @OpenInvId > 0
Begin
INSERT INTO OpenInventoryDetail_Department
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

INSERT INTO Warehouse_branch
    (
		Date,ItemId,Unit,Qty,Rate,[Type],SId,Did,BrId,[Desc],Amount,OpenInvId
    )
SELECT 
@Date,
myXML.value('./@ItemId', 'int'),
myXML.value('./@Unit', 'int'),
myXML.value('./@Qty', 'decimal(18,2)'),
myXML.value('./@Rate', 'decimal(18,2)'),
'In',@SId,@Did,@BRId,'Open',
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


