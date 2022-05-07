
CREATE Proc [dbo].[DeleteProduction]
@GRNID as int,
@GRNo as nvarchar(50)
as
begin try
begin Transaction
Declare @MasterTable as nvarchar(max);
Set @MasterTable='ProductionMaster';
Declare @DetailTable as nvarchar(max)
Set @DetailTable ='ProductionDetail';
declare @MasterQuery as nvarchar(max);
declare @DetailQuery as nvarchar(max);
set @DetailQuery='Delete from '+@DetailTable+' where PRId= ''' + CONVERT(VARCHAR(10),@GRNID, 101) + ''''
exec sp_executesql @DetailQuery
declare @CheckData as nvarchar(max);
set @MasterQuery='Delete from '+@MasterTable+' where PRId= ''' + CONVERT(VARCHAR(10),@GRNID, 101) + '''
and PRNo=''' + CONVERT(VARCHAR(10),@GRNo, 101) + ''' '
exec sp_executesql @MasterQuery
Commit
delete from WareHouse_Store where PDId=@GRNID
set @CheckData='Select * from '+@MasterTable+' m left join '+@DetailTable+' d on d.PRId=m.PRId where m.PRId=''' + CONVERT(VARCHAR(10),@GRNID, 101) + ''''
exec sp_executesql @CheckData
end try
begin catch
if @@Trancount>0
Rollback
exec uspGetErrorInfo
end catch









