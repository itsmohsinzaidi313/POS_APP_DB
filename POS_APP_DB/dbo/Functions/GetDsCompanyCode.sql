
CREATE function [dbo].[GetDsCompanyCode]-- '61'
(
@COId int
)
returns nvarchar(50)
as
Begin
Declare @Company nvarchar(50);
Declare @NewVoucher as nvarchar(max);
Declare @TableName nvarchar(max);
Declare @VoucherPara nvarchar(50);
Declare @NewVoucherCode nvarchar(50);


set @TableName = 'DemandSheetMaster_'+@Company;
set @VoucherPara= 'DS-';
select @NewVoucher = Max(DSNo) from DemandSheetMaster_Aylanto;

set @NewVoucherCode = @NewVoucher ;
--End
if @NewVoucherCode = 'DS-0001'
begin
set @NewVoucherCode = @NewVoucherCode + cast ((+1)  AS VARCHAR(10)) ;
End

return @NewVoucherCode

End



