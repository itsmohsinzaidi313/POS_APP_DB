
create proc [dbo].[uspInsertProfitLossSettings]

@XML xml

--@Section as nvarchar(50),
--@AccNoFrom as int,
--@AccNoTo as int,
--@Title as nvarchar(50)

as

BEGIN TRY
   BEGIN TRANSACTION   

DELETE FROM ProfitLossSettings


 

   COMMIT
INSERT INTO ProfitLossSettings
    (
        Section,
		AccNoFrom,
		AccNoTo,
		Title
    )
SELECT 
           myXML.value('./@Section', 'nvarchar(50)')
         , myXML.value('./@AccNoFrom', 'int')
         , myXML.value('./@AccNoTo', 'int')
		 , myXML.value('./@Title', 'nvarchar(50)')
     
		
    FROM @XML.nodes('/doc/title') As nodes(myXML);
    SET NOCOUNT OFF;

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back

EXECUTE [uspGetErrorInfo]

END CATCH



