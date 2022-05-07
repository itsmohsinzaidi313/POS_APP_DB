CREATE Proc [dbo].[DeleteDemandSheetStore]
@DSCOid as int,
@DSNo as nvarchar(50)
as
begin try
begin Transaction
declare @MasterTable as nvarchar(max);
Set @MasterTable='DemandsheetMaster_Store';
declare @DetailTable as nvarchar(max);
Set @DetailTable='DemandsheetDetail_Store';
declare @MasterQuery as nvarchar(max);
declare @DetailQuery as nvarchar(max);

set @DetailQuery='Delete from '+@DetailTable+' where DSCOId= ''' + CONVERT(VARCHAR(10),@DSCOid, 101) + ''''
exec sp_executesql @DetailQuery

Commit

set @MasterQuery='Delete from '+@MasterTable+' where DSCOId= ''' + CONVERT(VARCHAR(10),@DSCOid, 101) + '''
and DSNo=''' + CONVERT(VARCHAR(10),@DSNo, 101) + ''' '
exec sp_executesql @MasterQuery

declare @CheckData as nvarchar(max);
set @CheckData='Select * from '+@MasterTable+' m left join '+@DetailTable+' d on d.DSCOId=m.DSCOId where m.DSCOId=''' + CONVERT(VARCHAR(10),@DSCOid, 101) + ''''
exec sp_executesql @CheckData

end try
begin catch
if @@Trancount>0
Rollback
exec uspGetErrorInfo
end catch




