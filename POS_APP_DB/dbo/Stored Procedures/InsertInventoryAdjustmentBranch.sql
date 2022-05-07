

CREATE Proc [dbo].[InsertInventoryAdjustmentBranch]
@BRId as int,
@Date as datetime,
@UserId as int,
@AdjNo as nvarchar(50),
@XML as xml,
@DId as int,
@Desc as nvarchar(max)
as
BEGIN TRY
   BEGIN TRANSACTION  

Declare @AdjId as  int;
set @AdjId=0;
Declare @Master as nvarchar(max);
Set @Master='InvAdjMaster_Branch';
Declare @Detail as nvarchar(max)
Set @Detail ='InvAdjDetail_Branch';

if @AdjNo <> '0'
begin 
Declare @ParamDefination1 as  nvarchar(max);
declare @SQLString1 as nvarchar(max);
SET @SQLString1='Insert Into '+@Master+' (Date,UserId,BRId,IsApprove,AdjNo,DId,[Desc]) 
values(''' + CONVERT(VARCHAR(10),@Date, 101) + ''',
''' + CONVERT(VARCHAR(10),@UserId, 101) + ''',''' + CONVERT(VARCHAR(10),@BRId, 101) + ''', 0 ,''' + CONVERT(VARCHAR(10),@AdjNo, 101) + ''',''' + CONVERT(VARCHAR(10),@DId, 101) + ''',''' + @Desc + ''' )
  Select @AdjId = Scope_Identity()'
Set @ParamDefination1=N'@AdjId int OUTPUT'
exec sp_executesql @SQLString1,@ParamDefination1,@AdjId=@AdjId OUTPUT
if @AdjId > 0
begin
declare @SQLString2 as nvarchar(max);
Declare @ParamDefination2 as  nvarchar(max);
SET @SQLString2='Insert Into '+@Detail+' (AdjBRId,ItemId,Unit,Qty,Rate,Type) 
SELECT 
''' + CONVERT(VARCHAR(10),@AdjId, 101) + ''',
 myXML.value(''./@ItemId'',''int''),myXML.value(''./@Unit'',''int''),
myXML.value(''./@Qty'', ''decimal (18,2)''),myXML.value(''./@Rate'', ''decimal (18,2)'')
,myXML.value(''./@Type'', ''nvarchar(50)'')
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


select @AdjId




