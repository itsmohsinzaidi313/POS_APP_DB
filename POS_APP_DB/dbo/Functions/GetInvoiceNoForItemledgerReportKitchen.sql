
CREATE Function [dbo].[GetInvoiceNoForItemledgerReportKitchen]
(
@Id as int
)
returns nvarchar(50)
as
begin
declare @InvoiceNo nvarchar(50);
declare @InvoiceId int;
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

declare @PSId int;
set @PSId =0;

declare @IssRTId int;
set @IssRTId =0;

declare @SaleReturn int;
set @SaleReturn =0;

select 
@InvoiceId = InvoiceId,
@IssId = IssId,
@InvAdjId = InvAdjId,
@PDId = PDId,
@PSId = PMId,
@IssRTId = IssRTId
from WareHouse_Branch where id = @Id

select @SaleReturn = PMId from WareHouse_Branch where id = @Id and  Type = 'In'
if @SaleReturn = 0
begin
if @InvoiceId > 0
begin
select @InvoiceNo = InvoiceNo from InvoiceMaster_Company where InvoiceId=@InvoiceId
end
else if @IssId > 0
begin
select @InvoiceNo = IssNo from IssuanceMaster_Store where IssId=@IssId
end
else if @PDId > 0
begin
select @InvoiceNo = PRNo from ProductionMasterdepartment where PRId=@PDId
end
else if @InvAdjId > 0
begin
select @InvoiceNo = AdjNo from InvAdjMaster_Store where AdjId=@InvAdjId
end
else if @PSId > 0
begin
select @InvoiceNo = ZNumber from ProductSaleMaster where PMId=@PSId
end
else if @IssRTId > 0
begin
select @InvoiceNo = IssRNo from IssuanceReturnMaster where IssRTId=@IssRTId
end
end 
else if @SaleReturn > 0
begin 
select @InvoiceNo = SRNo from POSSaleReturnMaster where Sid=@SaleReturn
end
return @InvoiceNo
end









