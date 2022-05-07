CREATE proc [dbo].[UspUpdateItemParLevel]

--@Id as int,
@ItemId as int,
--@BRId as int,
--@ParLevel as nvarchar(50)
@XML XML
as

--update ItemParlevel
--set
--
--ItemId =@ItemId,
--BRId=@BRId,
--ParLevel =@ParLevel
--
--where Id = @Id

BEGIN TRY
   BEGIN TRANSACTION   

delete from ItemParlevel where ItemId = @ItemId

    SET NOCOUNT OFF;

   COMMIT

Insert into ItemParLevel
(
ItemId,
BRId,
Parlevel,
SId,
DId
)

SELECT 
      
        @ItemId,
		 myXML.value('./@BRId', 'int'),
 myXML.value('./@ParLevel', 'decimal (18,2)'),
		 myXML.value('./@SId', 'int'),
myXML.value('./@DId', 'int')
		
    FROM @XML.nodes('/doc/title') As nodes(myXML);
 


END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH
