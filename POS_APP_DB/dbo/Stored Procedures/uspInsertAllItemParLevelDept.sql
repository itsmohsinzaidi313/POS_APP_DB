create proc [dbo].[uspInsertAllItemParLevelDept]
@BRId as int,
@SId as int,
@ParLevel as decimal(18,2),
@DId as int
as

insert into ItemParLevel (ItemId,BRId,ParLevel,SId,DId)
select i.ItemId,@BRId,@ParLevel,@SId,@DId from Item i