Create Proc [dbo].[UspUpdateUnitConversion] 
@Id as int,
@UnitFrom as nvarchar(50),
@UnitTo as nvarchar(50),
@Conversion as decimal
as


Update UnitConversion set UnitFrom=@UnitFrom,UnitTo=@UnitTo,Conversion=@Conversion 
where id = @Id Select Scope_Identity();