

CREATE Proc [dbo].[InsertDemandSheetBranch]
@BRId as int,
@Date as datetime,
@UserId as int,
@DSNo as nvarchar(50),
@XML as xml,
@DeptId as int,
@Desc as nvarchar(max)
as
BEGIN TRY
   BEGIN TRANSACTION  

Declare @DSId as  int;
set @DSId=0;
Declare @Master as nvarchar(max);
Set @Master='DemandSheetMaster_Branch';
Declare @Detail as nvarchar(max)
Set @Detail ='DemandSheetDetail_Branch';
Declare @Company as nvarchar(50);
if @DSNO <> '0'
begin 
Declare @ParamDefination1 as  nvarchar(max);
declare @SQLString1 as nvarchar(max);
SET @SQLString1='Insert Into '+@Master+' (BRId,Date,DSNo,UserId,DId,[Desc]) 
values(''' + CONVERT(VARCHAR(10),@BRId, 101) + ''',''' + CONVERT(VARCHAR(10),@Date, 101) + ''',
''' + CONVERT(VARCHAR(10),@DSNO, 101) + ''',''' + CONVERT(VARCHAR(10),@UserId, 101) + ''',''' + CONVERT(VARCHAR(10),@DeptId, 101) + ''','''+ @Desc +''' )
  Select @DSId = Scope_Identity()'
Set @ParamDefination1=N'@DSId int OUTPUT'
exec sp_executesql @SQLString1,@ParamDefination1,@DSId=@DSId OUTPUT
if @DSId > 0
begin
declare @SQLString2 as nvarchar(max);
Declare @ParamDefination2 as  nvarchar(max);
SET @SQLString2='Insert Into '+@Detail+' (DSId,ItemId,Unit,Qty) 
SELECT 
''' + CONVERT(VARCHAR(10),@DSId, 101) + ''',
 myXML.value(''./@ItemId'',''int''),myXML.value(''./@Unit'',''int''),
myXML.value(''./@Qty'', ''decimal (18,2)'')
FROM @XML.nodes(''/doc/title'') As nodes(myXML)'
Set @ParamDefination2=N'@XML xml OUTPUT'
exec sp_executesql @SQLString2,@ParamDefination2,@XML=@XML OUTPUT

    SET NOCOUNT OFF;
end
end

   COMMIT

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
exec uspGetErrorInfo
END CATCH

select @DSId


