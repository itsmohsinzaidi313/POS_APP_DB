create Proc [dbo].[DeleteExpensePayment] --'CASH',57,57,'CPV-0003'
@Type as nvarchar(50),
@PVId as int,
@id as int,
@Vn as nvarchar(50)
as 
--delete from ProjectLedger where VoucherId = @id and VN = @Vn
delete from GL where VoucherId = @id and VN = @Vn
if @Type = 'CASH'
begin
set @PVId = 0;
select @PVId = PVId from CashPaymentMaster where CPId = @id

delete from CashPaymentDetail where CPId = @id
delete from CashPaymentMaster where CPId = @id


end
else
begin

set @PVId = 0;
select @PVId = PVId from BankPaymentMaster where BPId = @id

delete from BankPaymentDetail where BPId = @id
delete from BankPaymentMaster where BPId = @id

end

delete from PaymentVoucher where PVId = @PVId

declare @Chkid as int;
set @Chkid = 0;
Select @Chkid = id from GL where VoucherId = @id and VN = @Vn
Select @Chkid;
