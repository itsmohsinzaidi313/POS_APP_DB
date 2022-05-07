CREATE Proc [dbo].[DeleteInvoiceCompany]--'INV-0002',90
@InvoiceNo as nvarchar(50),
@InvoiceId as int
as
begin try
begin Transaction
Declare @MasterTable as nvarchar(max);
Set @MasterTable='InvoiceMaster_Company';
Declare @DetailTable as nvarchar(max)
Set @DetailTable ='InvoiceDetail_Company';
declare @MasterQuery as nvarchar(max);
declare @DetailQuery as nvarchar(max);
declare @Sid as int;
set @Sid=0;
declare @BRId as int;
set @BRId=0;
declare @Count as int;
set @Count=0

select @Sid=isnull(Sid,0) from InvoiceMaster_Company where InvoiceId=@InvoiceId;
select @BRId=isnull(BRId,0) from InvoiceMaster_Company where InvoiceId=@InvoiceId;
if @Sid > 0
begin
Delete from SupplierLedger where VoucherId=@InvoiceId 
select @Count=isnull(id,0) from SupplierLedger where VoucherId=@InvoiceId 
end 
else
--begin
--Delete from WareHouse_Branch where InvoiceId=@InvoiceId 
--select @Count=isnull(id,0) from WareHouse_Branch where InvoiceId=@InvoiceId 
--end
if @Count=0
begin

set @DetailQuery='Delete from '+@DetailTable+' where InvoiceId= ''' + CONVERT(VARCHAR(10),@InvoiceId, 101) + ''''
exec sp_executesql @DetailQuery
set @MasterQuery='Delete from '+@MasterTable+' where InvoiceId= ''' + CONVERT(VARCHAR(10),@InvoiceId, 101) + '''
and InvoiceNo=''' + CONVERT(VARCHAR(10),@InvoiceNo, 101) + ''' '
exec sp_executesql @MasterQuery
end

Commit
declare @CheckData as nvarchar(max);
set @CheckData='Select * from '+@MasterTable+' m left join '+@DetailTable+' d on d.InvoiceId=m.InvoiceId where m.InvoiceId=''' + CONVERT(VARCHAR(10),@InvoiceId, 101) + ''''
exec sp_executesql @CheckData

end try
begin catch
if @@Trancount>0
Rollback
--exec uspGetErrorInfo
end catch



