

CREATE Function [dbo].[GetInvoiceNoForItemledgerReport]
(
@Id as int
--,
--@VoucherType as nvarchar(50)
)
returns nvarchar(50)
as
begin
declare @InvoiceNo nvarchar(50);
declare @InvoiceId int;
set @InvoiceNo = '0';

set @InvoiceId =0;
declare @IssId int;
set @IssId =0;

declare @TRInId int;
set @TRInId =0;

declare @TROutId int;
set @TROutId =0;

declare @InvAdjId int;
set @InvAdjId =0;

declare @PDId int;
set @PDId =0;

declare @BUTId int;
set @BUTId =0;

declare @TRNInId int;
set @TRNInId =0;

declare @TRNOutId int;
set @TRNOutId =0;

declare @BUTRId int;
set @BUTRId =0;

declare @PRId int;
set @PRId =0;

declare @IssRTId int;
set @IssRTId =0;

declare @OpenInvId int;
set @OpenInvId =0;

declare @CustSaleInvId int;
set @CustSaleInvId =0;

select 
@InvoiceId = InvoiceId,
@IssId = IssId,
@InvAdjId = InvAdjId,
@PDId = PDId,
@BUTId = BUTId,
@TRNInId = TRInId,
@TRNOutId = TROutId,
@BUTRId = BUTRId,
@PRId = PRId,
@IssRTId = IssRTId,
@OpenInvId = OpenInvId,
@TRInId = TRInId,
@TROutId = TROutId,
@CustSaleInvId = SLId
from WareHouse_Store where id = @Id

if @InvoiceId > 0
begin
--select @InvoiceNo = GRNo from GRNMaster where GRNId=@InvoiceId
select @InvoiceNo = InvoiceNo from InvoiceMaster_Company where InvoiceId=@InvoiceId

if @InvoiceNo = '0'
begin
select @InvoiceNo = GRNo from GRNMaster where GRNId=@InvoiceId
end

end
else if @IssId > 0
begin
select @InvoiceNo = IssNo from IssuanceMaster_Store where IssId=@IssId
end
else if @PDId > 0
begin
select @InvoiceNo = PRNo from ProductionMaster where PRId=@PDId
end
else if @InvAdjId > 0
begin
select @InvoiceNo = AdjNo from InvAdjMaster_Store where AdjId=@InvAdjId
end
else if @BUTId > 0
begin
select @InvoiceNo = IssBNo from IssuanceButcheryMaster where BUTId=@BUTId
end
--else if @TRNInId > 0
--begin
--select @InvoiceNo = TRInId from TransferInMaster where TRInId=@TRNInId
--end
--else if @TRNOutId > 0
--begin
--select @InvoiceNo = TROutId from TransferOutMaster where TROutId=@TRNOutId
--end

else if @BUTRId > 0
begin
select @InvoiceNo = BURNo from ButcheryReturnMaster where BUTRId=@BUTRId
end
else if @PRId > 0
begin
select @InvoiceNo = PRNo from PurchaseReturnMaster where PRId=@PRId
end
else if @IssRTId > 0
begin
select @InvoiceNo = IssRNo from IssuanceReturnMaster where IssRTId=@IssRTId
end
else if @OpenInvId > 0
begin
select @InvoiceNo = 'OPEN'
end
else if @TRInId > 0
begin
Declare @TRId as int;
set @TRId = 0;
select @TRId = TransferId from TransferInMaster where TRIId = @TRInId
select @InvoiceNo = TRNo from Transfer where TransferId=@TRId
end
else if @TROutId > 0
begin
Declare @TRId_ as int;
set @TRId_ = 0;
select @TRId_ = TransferId from TransferOutMaster where TRId = @TROutId
select @InvoiceNo = TRNo from Transfer where TransferId=@TRId_
end
else if @CustSaleInvId > 0
begin
select @InvoiceNo = SaleInvoiceNo from CustomerSaleInvoiceMaster where SLId=@CustSaleInvId
end

--if @VoucherType = 'Purchase'
--begin
--select @InvoiceNo = InvoiceNo from InvoiceMaster_Company where InvoiceId=@InvoiceId
--end
--if @VoucherType = 'Issuance'
--begin
--select @InvoiceNo = InvoiceNo from InvoiceMaster_Company where InvoiceId=@InvoiceId
--end
--if @VoucherType = 'InvAdj'
--begin
--select @InvoiceNo = InvoiceNo from InvoiceMaster_Company where InvoiceId=@InvoiceId
--end
--if @VoucherType = 'TransferInn'
--begin
--select @InvoiceNo = InvoiceNo from InvoiceMaster_Company where InvoiceId=@InvoiceId
--end
--if @VoucherType = 'TransferOut'
--begin
--select @InvoiceNo = InvoiceNo from InvoiceMaster_Company where InvoiceId=@InvoiceId
--end

--select 
--
--
--select * from WareHouse_Store where ItemId = 14


return @InvoiceNo
end
