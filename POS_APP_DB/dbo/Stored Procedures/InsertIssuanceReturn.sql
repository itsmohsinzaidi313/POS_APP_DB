
CREATE Proc [dbo].[InsertIssuanceReturn]--'32','7/25/2013','85','10','ISSR-0001','<doc><title ItemId="34" UId="21" Rate="15.00" Qty="10" Amount="150.00" /></doc>'
@BRId as int,
@Date as datetime,
@SId as int,
@UserId as int,
@IssRNo as nvarchar(50)
,@XML as xml
as
BEGIN TRY
   BEGIN TRANSACTION  

Declare @IssRTId as  int;
set @IssRTId=0;
Declare @Master as nvarchar(max);
Set @Master='IssuanceReturnMaster';
Declare @Detail as nvarchar(max)
Set @Detail ='IssuanceReaturnDetail';

if @IssRTId <> '0'
begin 
Declare @ParamDefination1 as  nvarchar(max);
declare @SQLString1 as nvarchar(max);
SET @SQLString1='Insert Into '+@Master+' (Date,SId,BRId,UserId,IssRNo) 
values(''' + CONVERT(VARCHAR(10),@Date, 101) + ''',''' + CONVERT(VARCHAR(10),@SId, 101) + ''',''' + CONVERT(VARCHAR(10),@BRId, 101) + ''',
 ''' + CONVERT(VARCHAR(10),@UserId, 101) + ''',''' + CONVERT(VARCHAR(10),@IssRNo,101) + ''' )
  Select @IssId = Scope_Identity()'
Set @ParamDefination1=N'@IssRTId int OUTPUT'
exec sp_executesql @SQLString1,@ParamDefination1,@IssRTId=@IssRTId OUTPUT
if @IssRTId > 0
begin
declare @SQLString2 as nvarchar(max);
Declare @ParamDefination2 as  nvarchar(max);
SET @SQLString2='Insert Into '+@Detail+' (IssRTId,ItemId,Unit,Rate,QTY,Amount) 
SELECT 
''' + CONVERT(VARCHAR(10),@IssRTId, 101) + ''',
 myXML.value(''./@ItemId'',''int''),myXML.value(''./@UId'',''int'')
,myXML.value(''./@Rate'',''decimal(18,2)''),
myXML.value(''./@Qty'', ''decimal (18,2)''),
myXML.value(''./@Amount'', ''decimal (18,2)'')
 FROM @XML.nodes(''/doc/title'') As nodes(myXML)'
Set @ParamDefination2=N'@XML xml OUTPUT'
exec sp_executesql @SQLString2,@ParamDefination2,@XML=@XML OUTPUT

    SET NOCOUNT OFF;
end

insert into Warehouse_Store (IssRTId,Date,ItemId,Unit,Qty,Rate,[Type],SId,BRId)  
Select @IssRTId,@Date,myXML.value('./@ItemId', 'int'),myXML.value('./@UId', 'int')
, myXML.value('./@Qty', 'decimal(18,2)') , myXML.value('./@Rate', 'decimal(18,2)'),'In',@SId,@BRId

		
    FROM @XML.nodes('/doc/title') As nodes(myXML);
-- <doc><title
    SET NOCOUNT OFF;


end

   COMMIT

insert into Warehouse_Branch (IssRTId,Date,ItemId,Unit,Qty,Rate,[Type],SId,BRId)    
Select @IssRTId,@Date,myXML.value('./@ItemId', 'int'),myXML.value('./@UId', 'int')
, myXML.value('./@Qty', 'decimal(18,2)'), myXML.value('./@Rate', 'decimal(18,2)'),'Out',@SId,@BRId

		
    FROM @XML.nodes('/doc/title') As nodes(myXML);
-- <doc><title
    SET NOCOUNT OFF;

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
--exec uspGetErrorInfo
set @IssRTId = 0;
END CATCH
select @IssRTId


