
CREATE proc [dbo].[uspInsertPhysicalStockBranch]

@Date as datetime,
@PSNO as nvarchar(50),
@BRId as int,
@XML as xml,
@DId as int,
@Desc as nvarchar(max)

as

BEGIN TRY
   BEGIN TRANSACTION   

Declare @PSBRId int;

insert into PhysicalStockMaster_Branch
(Date,PSNO,BRId,DId,[Desc]) values (@Date,@PSNO,@BRId,@DId,@Desc)
select @PSBRId = scope_identity();

commit

INSERT INTO PhysicalStockDetail_Branch
    (
PSBRId,ItemId,UnitId,Qty,Amount
    )
SELECT 
@PSBRId,
          myXML.value('./@ItemId', 'int')
         , myXML.value('./@UId', 'int')
		, myXML.value('./@Qty', 'decimal(18,2)')
, myXML.value('./@Amount', 'decimal(18,2)')

		
   FROM @XML.nodes('/doc/title') As nodes(myXML);
 
    SET NOCOUNT OFF;

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back

--EXECUTE [uspGetErrorInfo]
END CATCH




