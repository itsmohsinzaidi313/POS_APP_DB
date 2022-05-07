
CREATE proc [dbo].[UspUpdateTax]
@Id as int,
@IsApplicable as bit,
@TaxType as nvarchar(50),
@Tax as decimal(18,2),
@Type as nvarchar(50)

as

Declare @IsExist as bit; 
set @IsExist = 0;

select @IsExist = id from Tax_  where Tax  = @Tax

if @IsExist = 0
begin
update Tax_ set

IsApplicable=@IsApplicable,
TaxType=@TaxType,
Tax=@Tax,
[Type]=@Type

where Id=@Id

end

select @IsExist;