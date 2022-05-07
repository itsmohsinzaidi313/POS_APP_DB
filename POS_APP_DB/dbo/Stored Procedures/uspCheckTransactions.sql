create proc [dbo].[uspCheckTransactions] 
@CAId as int,
@COId as int
as
select count(CAId) as TotalTrans from gl where CAId = @CAId and COId = @COId
