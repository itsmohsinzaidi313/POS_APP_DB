CREATE proc [dbo].[UspBindInvAdjStore]--'ADJ-0001'
@AdjNo as nvarchar(50)
as
select i.ItemId,i.Item,u.Unit as Unitt,u.UId as Unit,IAD.[Type],IAD.Qty,IAD.Rate
from InvAdjMaster_Store IAM
inner join InvAdjDetail_Store IAD on IAD.AdjId=IAM.AdjId
inner join Unit u on IAD.Unit=u.Uid
--inner join WareHouse_Store wh on wh.InvAdjId=IAD.AdjId
inner join Item i on i.ItemId=IAD.ItemId
where IAM.AdjNo=@AdjNo
