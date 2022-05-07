create proc [dbo].[uspSelectAccNatureByCAId]

@CAId as int

as

select AccNature from ChartOfAccount where CAId = @CAId
