Create Proc [dbo].[UspDeleteUnitConversion] 
@Id as int
as
Delete from UnitConversion where id = @Id Select Scope_Identity();