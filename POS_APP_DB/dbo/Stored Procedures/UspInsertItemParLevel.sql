create proc [dbo].[UspInsertItemParLevel]

@ItemId as int,
@BRId as int,
@ParLevel as nvarchar(50)

as

insert into ItemParLevel
(

ItemId ,
BRId ,
ParLevel
)
Values
(
@ItemId ,
@BRId ,
@ParLevel
)

