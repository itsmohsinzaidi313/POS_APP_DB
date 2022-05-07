create Proc [dbo].[DeletePurchaseOrderStore]
@PONo as nvarchar(50),
@POId as int
as
begin try
begin Transaction
Declare @MasterTable as nvarchar(max);
Set @MasterTable='PurchaseOrderMaster_Store';
Declare @DetailTable as nvarchar(max)
Set @DetailTable ='PurchaseOrderDetail_Store';
declare @MasterQuery as nvarchar(max);
declare @DetailQuery as nvarchar(max);
set @MasterQuery='Delete from '+@MasterTable+' where POId= ''' + CONVERT(VARCHAR(10),@POId, 101) + '''
and PONo=''' + CONVERT(VARCHAR(10),@PONo, 101) + ''' '
exec sp_executesql @MasterQuery
Commit
set @DetailQuery='Delete from '+@DetailTable+' where POId= ''' + CONVERT(VARCHAR(10),@POId, 101) + ''''
exec sp_executesql @DetailQuery
declare @CheckData as nvarchar(max);
set @CheckData='Select * from '+@MasterTable+' m left join '+@DetailTable+' d on d.POId=m.POId where m.POId=''' + CONVERT(VARCHAR(10),@POId, 101) + ''''
exec sp_executesql @CheckData

end try
begin catch
if @@Trancount>0
Rollback
exec uspGetErrorInfo
end catch

