create  Proc [dbo].[uspGetAllAccountForPaymentForm]
@Type as nvarchar(50),
@COId as int
as
Select CAId,AccName from ChartOfaccount where Type =@Type and COId = @COId  order by AccName
