create Function [dbo].[funcGetVoucherStatus]
(
@VN as  nvarchar(50),
@TotalAmount as decimal(18,2)
)
returns nvarchar(50)
as
begin
declare @Status nvarchar(50);
set @Status = 'NOT COMPLETED';
declare @Amount decimal(18,2);
set @Amount = 0;

select @Amount = isnull(sum(Amount),0) from ProjectLedger where VN = @VN

if @TotalAmount = @Amount
begin
set @Status = 'COMPLETED';
end
return @Status
end