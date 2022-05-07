CREATE function [dbo].[GetDsStoreCode] 
(
@SId int
)
returns nvarchar(50)
as
Begin
Declare @Company nvarchar(50);
Declare @Store nvarchar(50);
Declare @NewVoucher  nvarchar(max);
Declare @TableName nvarchar(50);
Declare @VoucherPara nvarchar(50);
Declare @Sql nvarchar(max);
Declare @ParamDefination as  nvarchar(max);
Declare @NewVoucherCode nvarchar(50);
declare @SQLString as nvarchar(max);

select @Company= c.Company from company c
inner join branch b on
c.COId=b.COId
inner join Store s on
s.BRId=b.BRId
where s.SId=@SId

select @Store = Store from Store where SId=@SId


set @TableName = 'DemandSheetMaster_'+@Company+'_'+@Store;
set @VoucherPara= 'DS-';
SET @SQLString= 'select Max(DSNo) from '+@TableName+'';
Set @ParamDefination=N'@NewVoucher varchar(50) OUTPUT'
exec sp_executesql @SQLString,@ParamDefination,@NewVoucher=@NewVoucher OUTPUT

--select @NewVoucher = Max(DSNo) from '+@TableName+'';
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
