Create Proc [dbo].[uspGetJVDetailById]
@JVId as int
as
Select j.CAId,c.AccName as Account,j.[Type],j.[Desc],j.Amount from JVDetail j
inner join ChartOfAccount  c on j.CAId = c.CAId where JVId =@JVId

