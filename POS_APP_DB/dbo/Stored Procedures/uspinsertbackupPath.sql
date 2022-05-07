Create proc [dbo].[uspinsertbackupPath]
@Path as nvarchar(1000)
as
insert into [Backup]
(
[Path]
)
Values
(
@Path
)