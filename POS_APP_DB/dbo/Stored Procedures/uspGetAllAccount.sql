create Proc [dbo].[uspGetAllAccount]
@Type as nvarchar(50),
@COId as int
as
Select CAId,AccName as Account from ChartOfaccount where Type =@Type and COId = @COId  order by AccName

