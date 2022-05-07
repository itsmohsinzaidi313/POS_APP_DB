CREATE proc [dbo].[uspDeleteGRN]--208

@GRNID as int
as
BEGIN TRY
   -- Start A Transaction
   BEGIN TRANSACTION   

delete from GRNDetail
where GRNId=@GRNID

   COMMIT

delete from GRNMaster
where GRNId=@GRNID

delete from WareHouse_Store
where InvoiceId=@GRNID 

Declare @G as int;
set @G = 0;
Declare @STRG as nvarchar(10);

select @STRG = isnull(GRNId,'0')  from GRNMaster
where GRNId=@GRNID

if @STRG = '0' or @STRG = 0
begin
set @G = 0;
end
else 
begin
set @G = 1;
end


END TRY
BEGIN CATCH

  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH
select @G;