CREATE Function [dbo].[GetInvoiceNoForSupplyledgerReportNew]
(
@Id as int
)
returns nvarchar(50)
as
begin
declare @InvoiceNo nvarchar(50);
declare @InvoiceId int;
set @InvoiceId =0;
declare @PRId int;
set @PRId =0;


select 
@InvoiceId = VoucherId,
@PRId = VoucherId
from SupplierLedger where id = @Id

if @InvoiceId > 0
begin
select @InvoiceNo = InvoiceNo from InvoiceMaster_Company where InvoiceId=@InvoiceId
end
if @PRId > 0
begin
select @InvoiceNo = PRNo from PurchaseReturnMaster where PRId=@PRId
end
return @InvoiceNo
end

