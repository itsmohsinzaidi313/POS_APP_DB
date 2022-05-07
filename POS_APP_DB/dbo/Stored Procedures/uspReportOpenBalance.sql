
CREATE proc [dbo].[uspReportOpenBalance]
as
select opm.Date,opm.type,i.ItemId,i.Item,u.Unit,opd.Qty,opd.Rate,opd.Amount
from OpenInventoryMaster opm
inner join OpenInventoryDetail opd on opm.OpenInvId = opd.OpenInvId
inner join Item i on opd.ItemId = i.ItemId
inner join ItemUnit iu on i.ItemId = iu.ItemId
inner join Unit u on iu.PurUnit = u.UId
order by opm.OpenInvId desc




