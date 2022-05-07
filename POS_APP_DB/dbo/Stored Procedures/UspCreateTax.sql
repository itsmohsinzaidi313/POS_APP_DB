
CREATE proc [dbo].[UspCreateTax]

@IsApplicable as bit,
@TaxType as nvarchar(50),
@Tax as decimal(18,2),
@Type as nvarchar(50)

as

Declare @Id as int; 
set @Id = 0;

Declare @IsExist as bit; 
set @IsExist = 0;

select @IsExist = id from Tax_  where Tax  = @Tax

if @IsExist = 0
begin

insert into Tax_
(
IsApplicable,
TaxType,
Tax,
[Type]
)
values
(
@IsApplicable,
@TaxType,
@Tax,
@Type
)

select @Id = scope_identity();
end
select @Id;