create proc [dbo].[uspGetCashAndBankReceiptVoucherNo]
@Type as nvarchar(10)
as
Declare @NewVoucher  nvarchar(max);
set @NewVoucher = '0';
Declare @TableName nvarchar(50);
Declare @VoucherPara nvarchar(50);
Declare @Sql nvarchar(max);
Declare @ParamDefination as  nvarchar(max);
Declare @NewVoucherCode nvarchar(50);
declare @SQLString as nvarchar(max);
Declare @ProductCode varchar(50);
if @Type = 'CASH'
begin 
set @TableName = 'CashReceiptMaster';
set @VoucherPara= 'CRV-';
SET @SQLString= 'select @NewVoucher = isnull(Max(VN),0) from '+@TableName+' ';
Set @ParamDefination=N'@NewVoucher varchar(50) OUTPUT'
exec sp_executesql @SQLString,@ParamDefination,@NewVoucher=@NewVoucher OUTPUT
end
else if  @Type = 'BANK'
begin 
set @TableName = 'BankReceiptMaster';
set @VoucherPara= 'BRV-';
SET @SQLString= 'select @NewVoucher = isnull(Max(VN),0) from '+@TableName+' ';
Set @ParamDefination=N'@NewVoucher varchar(50) OUTPUT'
exec sp_executesql @SQLString,@ParamDefination,@NewVoucher=@NewVoucher OUTPUT
End
if @NewVoucher = '0'
begin
if @Type = 'Cash'
begin 
set @NewVoucher = 'CRV-0001'
set @NewVoucherCode= @NewVoucher 
end
else if  @Type = 'bank'
begin
set @NewVoucher = 'BRV-0001'
set @NewVoucherCode= @NewVoucher 
end
End
else 
Begin
set @ProductCode = @NewVoucher;
SELECT @NewVoucher = RIGHT(@ProductCode,CHARINDEX('-',REVERSE (@ProductCode)) - 1)

set @NewVoucher = @NewVoucher+1;
if @NewVoucher < 10 begin
select @NewVoucherCode = '000' + CAST((@NewVoucher) AS VARCHAR(10)) end

else if @NewVoucher >= 10 and @NewVoucher < 100 begin
select @NewVoucherCode = '00' + CAST((@NewVoucher) AS VARCHAR(10)) end

else if @NewVoucher >= 100 and @NewVoucher < 1000 begin
select @NewVoucherCode = '0' + CAST((@NewVoucher) AS VARCHAR(10)) end

else if @NewVoucher >= 1000 begin
select @NewVoucherCode = @NewVoucher end

set @NewVoucherCode = @VoucherPara + @NewVoucherCode 
End

select @NewVoucherCode







