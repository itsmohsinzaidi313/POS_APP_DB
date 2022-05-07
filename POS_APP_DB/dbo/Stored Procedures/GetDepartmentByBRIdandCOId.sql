Create Proc [dbo].[GetDepartmentByBRIdandCOId]
@BRId as int,
@COId as int
as
Select id,department_name from DepartmentPOS where BRID = @BRId and COId = @COId