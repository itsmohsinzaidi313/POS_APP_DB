CREATE Proc [dbo].[GetTransferMasterById]
@id as int
as
Select t.TransferId,t.Date,t.TRNo,t.[From],t.[To],tom.TROutId ,tim.TRInId,t.TotalAmount  from Transfer t
inner join TransferOutMaster tom on t.TransferId = tom.TransferId
inner join TransferInMaster tim on t.TransferId = tim.TransferId
where t.TransferId =@id

