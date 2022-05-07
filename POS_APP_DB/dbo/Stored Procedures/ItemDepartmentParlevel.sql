
create Proc [dbo].[ItemDepartmentParlevel]
@BRId as int,
@DId as int
as
select i.ItemId, i.Item , Parlevel,IPL.BRId,IPL.SId 
from Item i 
inner join ItemParLevel IPL on IPL.ItemId=i.ItemId
where IPL.BRId=@BRId  and SId=0 and Did = @DId



