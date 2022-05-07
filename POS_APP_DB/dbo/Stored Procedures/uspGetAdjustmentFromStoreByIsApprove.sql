create proc [dbo].[uspGetAdjustmentFromStoreByIsApprove]
@IsApprove as bit
as
select ia.AdjId,ia.AdjNo,ia.Date,ia.IsApprove,u.UserName,s.Store
from InvAdjMaster_Store ia 
inner join [User] u on ia.UserId = u.UserId
inner join Store s on ia.SId = s.SId
where ia.IsApprove = @IsApprove