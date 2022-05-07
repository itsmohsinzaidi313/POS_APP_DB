create proc [dbo].[uspCheckAccNameExist]
@AccName as nvarchar(50),
@COId as int
as
select * from ChartOfAccount where AccName = @AccName and COId = @COId
