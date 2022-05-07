create Function [dbo].[GetChequeNo]
(
@VN as  nvarchar(50)
)
returns nvarchar(50)
as
begin
declare @ChequeNo nvarchar(50);
if @VN  like 'BPV%'
begin
select @ChequeNo = ChequeNo from BankPaymentMaster where VN=@VN
end
else if @VN  like 'BRV%'
begin
select @ChequeNo = ChequeNo from BankReceiptMaster where VN=@VN
end
return @ChequeNo
end

