CREATE PROC [dbo].[uspApiGetAllUsers]
AS
SELECT id, Tiltid [tiltId], username [name] from tbl_user
