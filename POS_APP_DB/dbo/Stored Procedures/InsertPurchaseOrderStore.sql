

CREATE proc [dbo].[InsertPurchaseOrderStore]

@Date as datetime,
@COId as int,
@PONo as nvarchar(50),
@VId as int,
@UserId as int,
@SId as int,
@XML as xml,
@Desc as nvarchar(max)
as

BEGIN TRY
   BEGIN TRANSACTION  

Declare @POId as  int;
set @POId=0;
Declare @Master as nvarchar(max);
Set @Master='PurchaseOrderMaster_Store';
Declare @Detail as nvarchar(max)
Set @Detail ='PurchaseOrderDetail_Store';

Declare @ParamDefination1 as  nvarchar(max);
declare @SQLString1 as nvarchar(max);
SET @SQLString1='Insert Into '+@Master+' (Date,COId,PONo,VId,UserId,SId,[Desc]) values
(''' + CONVERT(VARCHAR(10),@Date, 101) + ''',''' + CONVERT(VARCHAR(10),@COID, 101) + ''',''' + CONVERT(VARCHAR(10),@PONo, 101) + ''',
''' + CONVERT(VARCHAR(10),@VId, 101) + ''',
''' + CONVERT(VARCHAR(10),@UserId, 101) + ''',''' + CONVERT(VARCHAR(10),@SId, 101) + ''',''' + @Desc + ''')  Select @POId = Scope_Identity()'
Set @ParamDefination1=N'@POId int OUTPUT'
exec sp_executesql @SQLString1,@ParamDefination1,@POId=@POId OUTPUT
   COMMIT
if @POId > 0
begin
declare @SQLString2 as nvarchar(max);
Declare @ParamDefination2 as  nvarchar(max);
SET @SQLString2='Insert Into '+@Detail+' (POId,ItemId,UId,Rate,Amount,Qty,DSCOId,Status) 
SELECT 
''' + CONVERT(VARCHAR(10),@POId, 101) + ''',
myXML.value(''./@ItemId'',''int''),
myXML.value(''./@UId'',''int''),
myXML.value(''./@Rate'', ''decimal (18,2)''),
myXML.value(''./@Amount'', ''decimal (18,2)''),
myXML.value(''./@Qty'', ''decimal (18,2)''),
myXML.value(''./@DSCOId'', ''int''),''0''
FROM @XML.nodes(''/doc/title'') As nodes(myXML)'
Set @ParamDefination2=N'@XML xml OUTPUT'
exec sp_executesql @SQLString2,@ParamDefination2,@XML=@XML OUTPUT
    SET NOCOUNT OFF;
end

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
exec uspGetErrorInfo
END CATCH

select @POId







