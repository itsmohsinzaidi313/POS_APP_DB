
CREATE Proc [dbo].[InsertWareHouseStore]
@Date as datetime,
@InvoiceId as int,
@IssId as int,
@TRInId as int,
@TROutId as int,
@InvAdjId as int,
@Type as nvarchar(50),
@PDId as int,
@SId as int,
@XML as xml
as



BEGIN TRY
   BEGIN TRANSACTION  
Declare @Count as int;
set @Count=0;
declare @WareHouse as nvarchar(max);
Set @WareHouse ='WareHouse_Store';
declare @SQLString2 as nvarchar(max);
Declare @ParamDefination2 as  nvarchar(max);
SET @SQLString2='Insert Into '+@WareHouse+' (Date,ItemId,Unit,InvoiceId,IssId,TRInId,TROutId,InvAdjId,Qty,Rate,Type,PDId,Sid,Amount) 
SELECT 
''' + CONVERT(VARCHAR(10),@Date, 101) + ''',
 myXML.value(''./@ItemId'',''int''),
myXML.value(''./@Unit'',''int''),
''' + CONVERT(VARCHAR(10),@InvoiceId, 101) + ''',
''' + CONVERT(VARCHAR(10),@IssId, 101) + ''',
''' + CONVERT(VARCHAR(10),@TRInId, 101) + ''',
''' + CONVERT(VARCHAR(10),@TROutId, 101) + ''',
''' + CONVERT(VARCHAR(10),@InvAdjId, 101) + ''',
myXML.value(''./@Qty'', ''decimal (18,2)''),
myXML.value(''./@Rate'', ''decimal (18,2)''),
''' + CONVERT(VARCHAR(10),@Type, 101) + ''',
''' + CONVERT(VARCHAR(10),@PDId, 101) + ''',
''' + CONVERT(VARCHAR(10),@SId, 101) + ''',
myXML.value(''./@Amount'', ''decimal (18,2)'')
FROM @XML.nodes(''/doc/title'') As nodes(myXML)'
Set @ParamDefination2=N'@XML xml OUTPUT'
exec sp_executesql @SQLString2,@ParamDefination2,@XML=@XML OUTPUT
SET NOCOUNT OFF;

declare @ChkWareHouse as nvarchar(max);
Declare @ParamDef as  nvarchar(max);
set @ChkWareHouse = 'Select @Count= count(id) from '+@WareHouse+' where InvoiceId=''' + CONVERT(VARCHAR(10),@InvoiceId, 101) + ''''
Set @ParamDef=N'@Count int OUTPUT'
exec sp_executesql @ChkWareHouse,@ParamDef,@Count=@Count OUTPUT
if @Count>0
begin
Select @Count
end


   COMMIT

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
exec uspGetErrorInfo
END CATCH




