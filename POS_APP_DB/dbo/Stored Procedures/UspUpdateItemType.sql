Create proc [dbo].[UspUpdateItemType]

@Id as int,
@ItemType as nvarchar(50)

as
update Butchery
set 
ItemType=@ItemType

where Id=@Id


