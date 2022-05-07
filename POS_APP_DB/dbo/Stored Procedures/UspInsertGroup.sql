CREATE proc [dbo].[UspInsertGroup]
@COId as int,
@Group as nvarchar(50)


as

insert into [Group]
(
COId,
[Group]
)
Values
(
@COId,
@Group
)


