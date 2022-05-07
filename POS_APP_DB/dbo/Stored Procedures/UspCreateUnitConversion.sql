CREATE Proc [dbo].[UspCreateUnitConversion] 
@UnitFrom as nvarchar(50),
@UnitTo as nvarchar(50),
@Conversion as decimal
as
Insert into UnitConversion(UnitFrom,UnitTo,Conversion) values (@UnitFrom,@UnitTo,@Conversion) Select Scope_Identity();