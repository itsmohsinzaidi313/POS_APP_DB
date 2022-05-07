CREATE Proc [dbo].[DeleteCustomerReceipt] --'CASH',30,17,'CPV-0001'
@Type as nvarchar(50),
@PVId as int,
@id as int,
@Vn as nvarchar(50)
as


if @Type = 'CASH'
begin
delete from CashReceiptDetail where CRId = @id
delete from CashReceiptMaster where CRId = @id

end
else
begin
delete from BankReceiptDetail where BRId = @id
delete from BankReceiptMaster where BRId = @id

end

Delete from CustomerLedger where VoucherId= @id and VN = @Vn
delete from ReceiptVoucher where RVId = @PVId 
--and Type='Customer Receipt'
--delete from ProjectLedger where VoucherId = @id and VN = @Vn
delete from GL where VoucherId = @id and VN = @Vn


declare @Chkid as int;
set @Chkid = 0;
Select @Chkid = id from GL where VoucherId = @id and VN = @Vn
Select @Chkid;







