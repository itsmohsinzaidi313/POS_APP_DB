
CREATE proc [dbo].[GetButcheryMasterReturn]--32
@SId as int
as
select im.BUTRId,im.Date,im.BURNo,s.Store,s.SId,isbm.ISSBNo,im.BUTId 
from ButcheryReturnMaster im
inner join Store s on im.SId = s.SId
inner join IssuanceButcheryMaster isbm on im.BUTId = isbm.BUTId
where s.SId = @SId