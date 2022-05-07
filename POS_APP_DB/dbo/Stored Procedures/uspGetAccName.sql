create proc [dbo].[uspGetAccName]
@AccNature as nvarchar(max),
@Type as nvarchar(max),
@COId as int
as
select CAId,AccName from ChartOfAccount where [Type] = @Type and AccNature = @AccNature and COId = @COId
