create proc [dbo].[uspGetAccountLevel]

@COId as int

as

--select * from AccountLevel where COId = @COId

select LevelId,Cast([Level] as nvarchar(50)) as [Level] from AccountLevel where COId = @COId

