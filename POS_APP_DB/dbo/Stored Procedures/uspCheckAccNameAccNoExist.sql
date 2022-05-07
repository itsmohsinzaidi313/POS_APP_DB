create proc [dbo].[uspCheckAccNameAccNoExist]
@AccName as nvarchar(50),
@COId as int,
@AccNo as int
as
select * from ChartOfAccount where AccName = @AccName or AccNo = @AccNo and COId = @COId
