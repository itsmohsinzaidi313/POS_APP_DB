create proc [dbo].[getCAIdbyCustomerId]
@CUSTID as int
as
Select isnull(CAId,0) from Customer where CustId=@CUSTID
