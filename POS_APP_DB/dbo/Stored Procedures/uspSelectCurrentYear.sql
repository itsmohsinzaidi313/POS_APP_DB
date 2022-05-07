create proc [dbo].[uspSelectCurrentYear]
@COId as int
as

select * from AccountPeriod where IsActive = 1 and COId = @COId

