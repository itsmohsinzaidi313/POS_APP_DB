

CREATE proc [dbo].[GetIssuanceMasterReturn]--32
@BRId as int
as
select im.IssRTId,im.Date,im.IssRNo,b.Branch,b.BRId,im.DId from IssuanceReturnMaster im
 inner join Branch b on im.BRId = b.BRId
where b.BRId = @BRId