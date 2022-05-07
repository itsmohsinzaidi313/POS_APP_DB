Create proc [dbo].[UspCreateItemType]

@ItemType as nvarchar(50)

as

insert into Butchery
(

ItemType
)
values
(

@ItemType
)
