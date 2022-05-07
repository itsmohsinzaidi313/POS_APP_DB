create proc [dbo].[uspDeleteJV]

@JVId int

as
declare @Count as int;
set @Count = 0;
BEGIN TRY
   BEGIN TRANSACTION   

delete from JvMaster where JVId = @JVId

   COMMIT
delete from JVDetail where  JVId = @JVId
delete from GL where VoucherId = @JVId and VoucherType ='JOURNAL VOUCHER'
select @Count = id from Gl where VoucherId = @JVId and VoucherType ='JOURNAL VOUCHER'


END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
END CATCH



