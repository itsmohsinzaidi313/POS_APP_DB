CREATE Proc [dbo].[DeleteInventoryAdjustmentStore]
@AdjId as int,
@AdjNo as nvarchar(50)
as
begin try
begin Transaction
Declare @Master as nvarchar(max);
Set @Master='InvAdjMaster_Store';
Declare @Detail as nvarchar(max)
Set @Detail ='InvAdjDetail_Store';
declare @DetailQuery as nvarchar(max);
declare @MasterQuery as nvarchar(max);
set @MasterQuery='Delete from '+@Master+' where AdjId= ''' + CONVERT(VARCHAR(10),@AdjId, 101) + ''' and AdjNo= ''' + CONVERT(VARCHAR(10),@AdjNo, 101) +''' '
exec sp_executesql @MasterQuery
Commit
set @DetailQuery='Delete from '+@Detail+' where AdjId= ''' + CONVERT(VARCHAR(10),@AdjId, 101) + ''' '
exec sp_executesql @DetailQuery
end try
begin catch
if @@Trancount>0
Rollback
exec uspGetErrorInfo
end catch





