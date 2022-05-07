create proc [dbo].[UspDeleteItemParlevel]

@Id as int

as

delete from ItemParlevel
where
Id=@Id
