create Proc [dbo].[DeleteGoodReceivingByGRNNo]
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
declare @GRNID as int;
set @GRNID=0;
Select @GRNID=isnull(GRNId,0) from GRNMaster where GRNo=@GRNo;
if @GRNID >0
begin

set @DetailQuery='Delete from '+@DetailTable+' where GRNId= ''' + CONVERT(VARCHAR(10),@GRNID, 101) + ''''
exec sp_executesql @DetailQuery
declare @CheckData as nvarchar(max);

set @MasterQuery='Delete from '+@MasterTable+' where GRNId= ''' + CONVERT(VARCHAR(10),@GRNID, 101) + '''
and GRNo=''' + CONVERT(VARCHAR(10),@GRNo, 101) + ''' '
exec sp_executesql @MasterQuery
end

Commit
set @CheckData='Select * from '+@MasterTable+' m left join '+@DetailTable+' d on d.GRNId=m.GRNId where m.GRNId=''' + CONVERT(VARCHAR(10),@GRNID, 101) + ''''
exec sp_executesql @CheckData


end try
begin catch
if @@Trancount>0
Rollback
exec uspGetErrorInfo
end catch

