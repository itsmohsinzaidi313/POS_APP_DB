create proc [dbo].[UspInsertItem]

@SBId as int,
@Item as nvarchar(50),
@GRId as int

as

insert into Item
(

SBId,
Item ,
GRId 
)
Values
(
@SBId,
@Item ,
@GRId 
)

