create Proc [dbo].[DeleteDemandSheetBranch]
@DSid as int,
@DSNo as nvarchar(50)
as

begin try
begin Transaction
declare @MasterTable as nvarchar(max);
Set @MasterTable='DemandsheetMaster_Branch';
declare @DetailTable as nvarchar(max);
Set @DetailTable='DemandsheetDetail_Branch';
declare @MasterQuery as nvarchar(max);
declare @DetailQuery as nvarchar(max);
set @MasterQuery='Delete from '+@MasterTable+' where DSId= ''' + CONVERT(VARCHAR(10),@DSid, 101) + '''
and DSNo=''' + CONVERT(VARCHAR(10),@DSNo, 101) + ''' '
exec sp_executesql @MasterQuery
Commit
set @DetailQuery='Delete from '+@DetailTable+' where DSId= ''' + CONVERT(VARCHAR(10),@DSid, 101) + ''''
exec sp_executesql @DetailQuery
declare @CheckData as nvarchar(max);
set @CheckData='Select * from '+@MasterTable+' m left join '+@DetailTable+' d on d.DSId=m.DSId where m.DSId=''' + CONVERT(VARCHAR(10),@DSid, 101) + ''''
exec sp_executesql @CheckData

end try
begin catch
if @@Trancount>0
Rollback
exec uspGetErrorInfo
end catch



