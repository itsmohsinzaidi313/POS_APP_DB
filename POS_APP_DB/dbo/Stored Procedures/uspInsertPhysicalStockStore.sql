
CREATE proc [dbo].[uspInsertPhysicalStockStore]

@Date as datetime,
@PSNO as nvarchar(50),
@SId as int,
@XML as xml,
@Desc as nvarchar(max)

as

BEGIN TRY
   BEGIN TRANSACTION   

Declare @PsId int;

insert into PhysicalStockMaster_Store
(Date,PSNO,SId,[Desc]) values (@Date,@PSNO,@SId,@Desc)
select @PsId = scope_identity();

commit

INSERT INTO PhysicalStockDetail_Store
    (
PsId,ItemId,UId,Qty,Amount
    )
SELECT 
@PsId,
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


select @PsId;

