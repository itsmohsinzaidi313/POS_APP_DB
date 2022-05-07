CREATE function [dbo].[uspGetItemAvgRateKitchenDeptFunc]
(
@BRId int,
@DId int,
@ItemId  int,
@Date datetime,
@ByDate bit
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

if @ByDate = 0
begin 

select @Qty = isnull(sum(Qty),0) from WareHouse_Branch where ItemId = @ItemId and BRId = @BRId and DId = @DId and [Type] = 'In' and IssId > 0
select @Amount = isnull(sum(Amount),0) from WareHouse_Branch where ItemId = @ItemId and BRId = @BRId and DId = @DId and [Type] = 'In' and IssId > 0

End
else if @ByDate = 1
begin 

select @Qty = isnull(sum(Qty),0) from WareHouse_Branch where Date <= @Date and ItemId = @ItemId and BRId = @BRId and DId = @DId and [Type] = 'In' and IssId > 0
select @Amount = isnull(sum(Amount),0) from WareHouse_Branch where Date <= @Date and ItemId = @ItemId and BRId = @BRId and DId = @DId and [Type] = 'In' and IssId > 0
End
set @AvgRate = @Amount / nullif(@Qty, 0);

return @AvgRate 
End

