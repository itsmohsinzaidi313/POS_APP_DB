CREATE Proc [dbo].[DeleteIssuanceStore]
@IssId as int,
@IssNo as nvarchar(50)
as

begin try
begin Transaction
Declare @MasterTable as nvarchar(max);
Set @MasterTable='IssuanceMaster_Store';
Declare @DetailTable as nvarchar(max)
Set @DetailTable ='IssuanceDetail_Store';
declare @MasterQuery as nvarchar(max);
declare @DetailQuery as nvarchar(max);
set @DetailQuery='Delete from '+@DetailTable+' where IssId= ''' + CONVERT(VARCHAR(10),@IssId, 101) + ''''
exec sp_executesql @DetailQuery

Commit
set @MasterQuery='Delete from '+@MasterTable+' where IssId= ''' + CONVERT(VARCHAR(10),@IssId, 101) + '''
and IssNo=''' + CONVERT(VARCHAR(10),@IssNo, 101) + ''' '
exec sp_executesql @MasterQuery

declare @CheckData as nvarchar(max);
set @CheckData='Select * from '+@MasterTable+' m left join '+@DetailTable+' d on d.IssId=m.IssId where m.IssId=''' + CONVERT(VARCHAR(10),@IssId, 101) + ''''
exec sp_executesql @CheckData

delete from WareHouse_Store where IssId = @IssId
delete from WareHouse_Branch where IssId = @IssId
delete from GL where VoucherId = @IssId and VN = @IssNo


end try
begin catch
if @@Trancount>0
Rollback
exec uspGetErrorInfo
end catch