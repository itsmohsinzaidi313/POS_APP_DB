create proc [dbo].[UspUpdateGroup]

@GRId as int,
@Group as nvarchar(50)
as

update [Group]
set
[Group] =@Group


where GRId = @GRId

