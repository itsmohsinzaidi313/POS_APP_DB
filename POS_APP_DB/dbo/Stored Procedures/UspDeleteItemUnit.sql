create proc [dbo].[UspDeleteItemUnit]

@id as int

as

delete from ItemUnit
where
id=@id
