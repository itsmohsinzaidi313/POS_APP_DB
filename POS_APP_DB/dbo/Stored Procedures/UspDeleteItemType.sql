Create proc [dbo].[UspDeleteItemType]

@Id as int

as
Delete from Butchery
where Id=@Id


