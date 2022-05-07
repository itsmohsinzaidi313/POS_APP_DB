
CREATE Proc [dbo].[InsertIssuanceButchery]
@BRId as int,
@Date as datetime,
@SId as int,
@UserId as int,
@IssBNo as nvarchar(50),
@XML as xml
as
BEGIN TRY
   BEGIN TRANSACTION  

Declare @BUTId as  int;
set @BUTId=0;
Declare @Master as nvarchar(max);
Set @Master='IssuanceButcheryMaster';
Declare @Detail as nvarchar(max)
Set @Detail ='IssuanceButcheryDetail';

if @IssBNo <> '0'
begin 
Declare @ParamDefination1 as  nvarchar(max);
declare @SQLString1 as nvarchar(max);
SET @SQLString1='Insert Into '+@Master+' (Date,Sid,BRId,UserId,IssBNo) 
values(''' + CONVERT(VARCHAR(10),@Date, 101) + ''',''' + CONVERT(VARCHAR(10),@SId, 101) + ''',''' + CONVERT(VARCHAR(10),@BRId, 101) + ''',
 ''' + CONVERT(VARCHAR(10),@UserId, 101) + ''',,''' + CONVERT(VARCHAR(10),@IssBNo,101) + ''' )
  Select @BUTId = Scope_Identity()'
Set @ParamDefination1=N'@IssId int OUTPUT'
exec sp_executesql @SQLString1,@ParamDefination1,@BUTId=@BUTId OUTPUT
if @BUTId > 0
begin
declare @SQLString2 as nvarchar(max);
Declare @ParamDefination2 as  nvarchar(max);
SET @SQLString2='Insert Into '+@Detail+' (BUTId,ItemId,Unit,Rate,Qty,Amount) 
SELECT 
''' + CONVERT(VARCHAR(10),@BUTId, 101) + ''',
 myXML.value(''./@ItemId'',''int''),myXML.value(''./@UId'',''int''),myXML.value(''./@Rate'',''decimal(18,2)''),
myXML.value(''./@Qty'', ''decimal (18,2)''),myXML.value(''./@Amount'', ''decimal (18,2)'') FROM @XML.nodes(''/doc/title'') As nodes(myXML)'
Set @ParamDefination2=N'@XML xml OUTPUT'
exec sp_executesql @SQLString2,@ParamDefination2,@XML=@XML OUTPUT

    SET NOCOUNT OFF;
end

  COMMIT

insert into Warehouse_Store (BUTId,Date,ItemId,Unit,Qty,Rate,[Type],SId,BRId)  
Select @BUTId,@Date,myXML.value('./@ItemId', 'int'),myXML.value('./@PurUnitId', 'int')
, myXML.value('./@Qty', 'decimal(18,2)') / myXML.value('./@Factor', 'decimal(18,2)'), myXML.value('./@Rate', 'decimal(18,2)') * myXML.value('./@Factor', 'decimal(18,2)'),'Out',@SId,@BRId

		
    FROM @XML.nodes('/doc/title') As nodes(myXML);
    SET NOCOUNT OFF;


end

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
--exec uspGetErrorInfo
set @BUTId = 0;
END CATCH
select @BUTId




