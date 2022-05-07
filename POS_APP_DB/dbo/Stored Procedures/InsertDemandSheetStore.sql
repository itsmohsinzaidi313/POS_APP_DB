


CREATE Proc [dbo].[InsertDemandSheetStore]
@COID as int,
@Date as datetime,
@DSNo as nvarchar(50),
@SId as int,
@XML as xml
,
@Desc as nvarchar(max)
as
BEGIN TRY
   BEGIN TRANSACTION  
Declare @DSCOId as  int;
set @DSCOId=0;
Declare @Master as nvarchar(max);
Set @Master='DemandSheetMaster_Store';
Declare @Detail as nvarchar(max)
Set @Detail ='DemandSheetDetail_Store';

Declare @ParamDefination1 as  nvarchar(max);
declare @SQLString1 as nvarchar(max);
SET @SQLString1='Insert Into '+@Master+' (SId,Date,DSNo,COId,[Desc]) values(''' + CONVERT(VARCHAR(10),@SId, 101) + ''',''' + CONVERT(VARCHAR(10),@Date, 101) + ''',''' + CONVERT(VARCHAR(10),@DSNO, 101) + ''',''' + CONVERT(VARCHAR(10),@COID, 101) + ''',''' + @Desc + ''')  Select @DSCOId = Scope_Identity()'
Set @ParamDefination1=N'@DSCOId int OUTPUT'
exec sp_executesql @SQLString1,@ParamDefination1,@DSCOId=@DSCOId OUTPUT

if @DSCOID > 0
begin
declare @SQLString3 as nvarchar(max);
Declare @ParamDefination3 as  nvarchar(max);
SET @SQLString3='Insert Into '+@Detail+' (DSCOID,ItemId,Unit,Qty,Status) 
SELECT 
''' + CONVERT(VARCHAR(10),@DSCOID, 101) + ''',
 myXML.value(''./@ItemId'',''int''),myXML.value(''./@Unit'',''int''),
myXML.value(''./@Qty'', ''decimal (18,2)''),''0''
FROM @XML.nodes(''/doc/title'') As nodes(myXML)'
Set @ParamDefination3=N'@XML xml OUTPUT'
exec sp_executesql @SQLString3,@ParamDefination3,@XML=@XML OUTPUT
    SET NOCOUNT OFF;

end
   COMMIT

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
exec uspGetErrorInfo
set @DSCOId=0;

END CATCH
select @DSCOId;

