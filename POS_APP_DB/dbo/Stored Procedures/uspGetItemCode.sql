CREATE proc [dbo].[uspGetItemCode] 
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

set @TableName = 'Item';
set @VoucherPara= 'I-';

SET @SQLString= 'select @NewVoucher = isnull(Max(ItemCode),0) from '+@TableName+'';

Set @ParamDefination=N'@NewVoucher varchar(50) OUTPUT'
exec sp_executesql @SQLString,@ParamDefination,@NewVoucher=@NewVoucher OUTPUT

if @NewVoucher = '0'
begin
set @NewVoucher = 'I-0001'
set @NewVoucherCode= @NewVoucher 
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




