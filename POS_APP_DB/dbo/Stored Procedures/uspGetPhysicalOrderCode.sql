CREATE proc [dbo].[uspGetPhysicalOrderCode] 
@SId as int
as
Declare @NewVoucher as nvarchar(max);
set @NewVoucher = '0';
Declare @TableName nvarchar(max);
Declare @VoucherPara nvarchar(50);
Declare @Sql nvarchar(max);
Declare @ParamDefination as  nvarchar(max);
Declare @NewVoucherCode nvarchar(50);
declare @SQLString as nvarchar(max);
Declare @ProductCode varchar(50);

set @TableName = 'PhysicalStockMaster_Store';
set @VoucherPara= 'PHO-';
SET @SQLString= 'select @NewVoucher = isnull(Max(PSNO),0) from '+@TableName+' where SId=''' + CONVERT(VARCHAR(10),@SId, 101) + '''';

Set @ParamDefination=N'@NewVoucher varchar(50) OUTPUT '
exec sp_executesql @SQLString,@ParamDefination,@NewVoucher=@NewVoucher OUTPUT

if @NewVoucher = '0'
begin
set @NewVoucher = 'PHO-0001'
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




