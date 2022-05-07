CREATE Proc [dbo].[DeleteGoodReceiving]
@GRNID as int,
@GRNo as nvarchar(50)
as
begin try
begin Transaction
Declare @MasterTable as nvarchar(max);
Set @MasterTable='GRNMaster';
Declare @DetailTable as nvarchar(max)
Set @DetailTable ='GRNDetail';
declare @MasterQuery as nvarchar(max);
declare @DetailQuery as nvarchar(max);

set @DetailQuery='Delete from '+@DetailTable+' where GRNId= ''' + CONVERT(VARCHAR(10),@GRNID, 101) + ''''
exec sp_executesql @DetailQuery
declare @CheckData as nvarchar(max);

set @MasterQuery='Delete from '+@MasterTable+' where GRNId= ''' + CONVERT(VARCHAR(10),@GRNID, 101) + '''
and GRNo=''' + CONVERT(VARCHAR(10),@GRNo, 101) + ''' '
exec sp_executesql @MasterQuery

Commit
set @CheckData='Select * from '+@MasterTable+' m left join '+@DetailTable+' d on d.GRNId=m.GRNId where m.GRNId=''' + CONVERT(VARCHAR(10),@GRNID, 101) + ''''
exec sp_executesql @CheckData

end try
begin catch
if @@Trancount>0
Rollback
exec uspGetErrorInfo
end catch




