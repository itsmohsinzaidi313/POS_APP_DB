CREATE function [dbo].[GetPoCompanyCode] 
(
@COId int
)
returns nvarchar(50)
as
Begin
Declare @Company nvarchar(50);
Declare @NewVoucher  int;
Declare @TableName nvarchar(50);
Declare @VoucherPara nvarchar(50);
Declare @Sql nvarchar(max);
Declare @ParamDefination as  nvarchar(max);
Declare @NewVoucherCode nvarchar(50);
declare @SQLString as nvarchar(max);

select @Company = Company from Company where COId=@COId

set @TableName = 'PurchaseOrderMaster_'+@Company;
set @VoucherPara= 'PO-';
SET @SQLString= 'select Max(PONo)as PONO from '+@TableName+'';
Set @ParamDefination=N'@NewVoucher varchar(50) OUTPUT'
exec sp_executesql @SQLString,@ParamDefination,@NewVoucher=@NewVoucher OUTPUT
set @NewVoucher = @NewVoucher + 1;


if @NewVoucher < 10 begin
select @NewVoucherCode = '000' + CAST((@NewVoucher) AS VARCHAR(10)) end

else if @NewVoucher >= 10 and @NewVoucher < 100 begin
select @NewVoucherCode = '00' + CAST((@NewVoucher) AS VARCHAR(10)) end

else if @NewVoucher > 999 and @NewVoucher < 10000 begin
select @NewVoucherCode = '0' + CAST((@NewVoucher) AS VARCHAR(10)) end

else if @NewVoucher > 10000 begin
select @NewVoucherCode = @NewVoucher end

set @NewVoucherCode = @VoucherPara + @NewVoucherCode 
return @NewVoucherCode
End
