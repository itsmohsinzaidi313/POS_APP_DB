Create PROCEDURE [dbo].[usp_BackupDatabase]--'AylantoTest','D:\'
(
	@DatabaseName AS VARCHAR(256), --name of database to be backup
	@BackupPath AS VARCHAR(2000) --back path.format of the path is like "C:\Database\Backup\"
)
AS
BEGIN
	DECLARE @CurrentDate VARCHAR(50)
	SELECT @CurrentDate = CONVERT(VARCHAR(20),GETDATE(),106)
	--back file name will be "databasename_todaysdate.bak"
	SET @BackupPath = @BackupPath + @DatabaseName + '_' + @CurrentDate + '.' + 'bak'
    BACKUP DATABASE @DatabaseName TO DISK = @BackupPath
END
