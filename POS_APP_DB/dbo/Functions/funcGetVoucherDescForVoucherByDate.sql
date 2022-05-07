CREATE function [dbo].[funcGetVoucherDescForVoucherByDate]
(
@VN nvarchar(50),
@VoucherId int,
@CAId int
)
returns nvarchar(MAX)
as
Begin

Declare @Desc nvarchar(MAX);
set @Desc = '';

if @VN like 'BPV%'
Begin
select @Desc = id.[Desc] from BankPaymentMaster i 
inner join BankPaymentDetail id on i.BPId = id.BPId
where i.BPId = @VoucherId 
and id.CAId = @CAId
End
else if @VN like 'CPV%'
Begin
select @Desc = id.[Desc] from CashPaymentMaster i 
inner join CashPaymentDetail id on i.CPId = id.CPId
where i.CPId = @VoucherId 
and id.CAId = @CAId
End
else if @VN like 'CRV%'
Begin
select @Desc = id.[Desc] from CashReceiptMaster i 
inner join CashReceiptDetail id on i.CRId = id.CRId
where i.CRId = @VoucherId and id.CAId = @CAId
End
else if @VN like 'BRV%'
Begin
select @Desc = id.[Desc] from BankReceiptMaster i 
inner join BankReceiptDetail id on i.BRId = id.BRId
where i.BRId = @VoucherId and id.CAId = @CAId
End
else if @VN like 'JV%'
Begin
select @Desc = id.[Desc] from JVMaster i 
inner join JVDetail id on i.JVId = id.JVId
where i.JVId = @VoucherId and id.CAId = @CAId
End
else if @VN like 'PV%'
Begin
select @Desc = id.[Desc] from InvoiceMaster i 
inner join InvoiceDetail id on i.InvoiceId = id.InvoiceId
where i.InvoiceId = @VoucherId and id.CAId = @CAId
End
--else if @VN like 'PRV%'
--Begin
--select @Desc = id.[Desc] from PurchaseReturnMaster i 
--inner join PurchaseReturnDetail id on i.PRId = id.PRId
--where i.PRId = @VoucherId and id.CAId = @CAId
--End
else if @VN like 'SRV%'
Begin
select @Desc = id.[Desc] from SaleReturnMaster i 
inner join SaleReturnDetail id on i.SRId = id.SRId
where i.SRId = @VoucherId and id.CAId = @CAId
End
else if @VN like 'SALE%'
Begin
select @Desc = id.[Desc] from SaleInvoiceMaster i 
inner join SaleInvoiceDetail id on i.SaleInvoiceId = id.SaleInvoiceId
where i.SaleInvoiceId = @VoucherId and id.CAId = @CAId
End

return @Desc 
End



