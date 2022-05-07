


CREATE Proc [dbo].[DeleteSaleInvoiceBySLNo]
@SLNo as nvarchar(50)
as
begin try
begin Transaction
Declare @MasterTable as nvarchar(max);
Set @MasterTable='CustomerSaleInvoiceMaster';
Declare @DetailTable as nvarchar(max)
Set @DetailTable ='CustomerSaleInvoiceDetail';
declare @MasterQuery as nvarchar(max);
declare @DetailQuery as nvarchar(max);
declare @GRNID as int;
set @GRNID=0;
Select @GRNID=isnull(SLId,0) from CustomerSaleInvoiceMaster where SaleInvoiceNo=@SLNo;
if @GRNID >0
begin

set @DetailQuery='Delete from '+@DetailTable+' where SLId= ''' + CONVERT(VARCHAR(10),@GRNID, 101) + ''''
exec sp_executesql @DetailQuery
declare @CheckData as nvarchar(max);

set @MasterQuery='Delete from '+@MasterTable+' where SLId= ''' + CONVERT(VARCHAR(10),@GRNID, 101) + '''
and SaleInvoiceNo=''' + CONVERT(VARCHAR(10),@SLNo, 101) + ''' '
exec sp_executesql @MasterQuery
end

delete from Warehouse_store where SLId = @GRNID
delete from CustomerLedger where VN = @SLNo and VoucherId = @GRNID

Commit
set @CheckData='Select * from '+@MasterTable+' m left join '+@DetailTable+' d on d.SLId=m.SLId where m.SLId=''' + CONVERT(VARCHAR(10),@GRNID, 101) + ''''
exec sp_executesql @CheckData


end try
begin catch
if @@Trancount>0
Rollback
exec uspGetErrorInfo
end catch




