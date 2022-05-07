create function [dbo].[funcGetItemAvgRateInvoice]
(
@InvoiceId int,
@ItemId  int,
@UnitId int
)
returns decimal(18,2)
as
Begin

Declare @Amount decimal(18,2);
set @Amount =0;
Declare @Qty decimal(18,2);
set @Qty =0;
Declare @AvgRate decimal(18,2);
set @AvgRate =0;

select @Qty = isnull(sum(Qty),0) from InvoiceDetail_CompanyNew where ItemId = @ItemId and InvoiceId = @InvoiceId and Unit = @UnitId 
select @Amount = isnull(sum(Amount),0) from InvoiceDetail_CompanyNew where ItemId = @ItemId and InvoiceId = @InvoiceId and Unit = @UnitId 
set @AvgRate = @Amount / nullif(@Qty, 0);

return @AvgRate 
End