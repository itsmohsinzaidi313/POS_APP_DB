CREATE proc [dbo].[uspApiGetTables]
as
SELECT [id], [tables], [table_status] FROM [Tables]