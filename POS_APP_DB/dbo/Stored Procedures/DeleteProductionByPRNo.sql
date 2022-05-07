CREATE Proc [dbo].[DeleteProductionByPRNo]
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
declare @GRNID as int;
set @GRNID=0;
Select @GRNID=isnull(PRId,0) from ProductionMaster where PRNo=@GRNo;
if @GRNID >0
begin

set @DetailQuery='Delete from '+@DetailTable+' where PRId= ''' + CONVERT(VARCHAR(10),@GRNID, 101) + ''''
exec sp_executesql @DetailQuery
declare @CheckData as nvarchar(max);

set @MasterQuery='Delete from '+@MasterTable+' where PRId= ''' + CONVERT(VARCHAR(10),@GRNID, 101) + '''
and PRNo=''' + CONVERT(VARCHAR(10),@GRNo, 101) + ''' '
exec sp_executesql @MasterQuery
delete from WareHouse_branch where PDId=@GRNID
end

Commit
set @CheckData='Select * from '+@MasterTable+' m left join '+@DetailTable+' d on d.PDId=m.PDId where m.PDId=''' + CONVERT(VARCHAR(10),@GRNID, 101) + ''''
exec sp_executesql @CheckData


end try
begin catch
if @@Trancount>0
Rollback
exec uspGetErrorInfo
end catch




