create Proc [dbo].[GetTransferDetailByTransferId]
@id as int,
@Type as nvarchar(50)
as
if @Type = 'Store2Store'
begin
Select i.ItemId,i.Item,u.Unit,u.Uid,d.Qty,d.Rate as RatePerPcs,d.Qty * d.Rate as Amount,d.PackageId,u.Unit as [Type]
from Transfer T 
inner join TransferInMaster Tim on T.TransferId = Tim.TransferId
inner join TransferInDetail d on Tim.TRIId = d.TRIId
inner join Item i on i.ItemId = d.ItemId
inner join Unit u on d.Unit = u.UId where T.TransferId = @id
end
else if @Type = 'Other'
begin
Select i.ItemId,i.Item,u.Unit,u.Uid,d.Qty,d.Rate as RatePerPcs,d.Qty * d.Rate as Amount,ic.IssFactor as Factor,d.PackageId
from Transfer T 
inner join TransferInMaster Tim on T.TransferId = Tim.TransferId
inner join TransferInDetail d on Tim.TRIId = d.TRIId
inner join Item i on i.ItemId = d.ItemId
inner join Unit u on d.Unit = u.UId
inner join ItemUnit ic on i.ItemId = ic.ItemId
 where T.TransferId = @id
end

