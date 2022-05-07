CREATE Proc [dbo].[DeleteGoodRecev]--'INV-0001',11
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
declare @Sid as int;
set @Sid=0;
declare @BRId as int;
set @BRId=0;
declare @Count as int;
set @Count=0

select @Sid=isnull(Sid,0) from GRNMaster where GRNID=@GRNID;
select @BRId=isnull(BRId,0) from GRNMaster where GRNID=@GRNID;
if @Sid > 0
begin
Delete from WareHouse_Store where InvoiceId=@GRNID 
select @Count=isnull(id,0) from WareHouse_Store where InvoiceId=@GRNID 
end 
else
--begin
--Delete from WareHouse_Branch where InvoiceId=@InvoiceId 
--select @Count=isnull(id,0) from WareHouse_Branch where InvoiceId=@InvoiceId 
--end
if @Count=0
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
