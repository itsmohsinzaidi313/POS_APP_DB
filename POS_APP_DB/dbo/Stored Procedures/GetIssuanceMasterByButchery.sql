

CREATE proc [dbo].[GetIssuanceMasterByButchery]
@COId as int
as
select im.BUTId,im.Date,im.IssBNo
from IssuanceButcheryMaster im
inner join store s on im.SId = s.SId
where s.COId = @COId

