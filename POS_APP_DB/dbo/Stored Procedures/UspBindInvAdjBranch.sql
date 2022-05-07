CREATE proc [dbo].[UspBindInvAdjBranch]
@AdjNo as nvarchar(50)
as
select i.ItemId,i.Item,u.Unit as Unitt,u.UId as Unit,IAD.[Type],IAD.Qty,IAD.Rate
from InvAdjMaster_Branch IAM
inner join InvAdjDetail_Branch IAD on IAD.AdjBRId=IAM.AdjBRId
inner join Unit u on IAD.Unit=u.Uid
--inner join WareHouse_Branch wh on wh.InvAdjId=IAD.AdjBRId
inner join Item i on i.ItemId=IAD.ItemId
where IAM.AdjNo=@AdjNo



