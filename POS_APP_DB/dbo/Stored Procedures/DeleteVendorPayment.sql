CREATE Proc [dbo].[DeleteVendorPayment] --'CASH',30,17,'CPV-0001'
@Type as nvarchar(50),
@PVId as int,
@id as int,
@Vn as nvarchar(50)
as


Delete from SupplierLedger where VoucherId= @id and VN = @Vn
--delete from ProjectLedger where VoucherId = @id and VN = @Vn
delete from GL where VoucherId = @id and VN = @Vn
if @Type = 'CASH'
begin
select @PVId = PVId from CashPaymentMaster where CPId = @id

delete from CashPaymentMaster where CPId = @id
delete from CashPaymentDetail where CPId = @id
end
else
begin
select @PVId = PVId from bankPaymentMaster where BPId = @id

delete from BankPaymentMaster where BPId = @id
delete from BankPaymentDetail where BPId = @id
end
delete from PaymentVoucher where PVId = @PVId

declare @Chkid as int;
set @Chkid = 0;
Select @Chkid = id from GL where VoucherId = @id and VN = @Vn
Select @Chkid;
