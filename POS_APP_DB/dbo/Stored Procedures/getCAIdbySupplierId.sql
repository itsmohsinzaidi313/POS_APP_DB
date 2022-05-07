create proc [dbo].[getCAIdbySupplierId]
@SPID as int
as
Select isnull(CAId,0) from Vendor where VId=@SPID

