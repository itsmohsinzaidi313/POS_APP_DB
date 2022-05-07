
CREATE Proc [dbo].[InsertIssuanceStoreStockTaking]
@BRId as int,
@Date as datetime,
@SId as int,
@UserId as int,
@Type as nvarchar(50),
@IssNo as nvarchar(50),
@DSId as int,
@PSId as int,
@XML as xml
as
BEGIN TRY
   BEGIN TRANSACTION  

Declare @IssId as  int;
set @IssId=0;
Declare @Master as nvarchar(max);
Set @Master='IssuanceMaster_Store';
Declare @Detail as nvarchar(max)
Set @Detail ='IssuanceDetail_Store';

if @IssNo <> '0'
begin 
Declare @ParamDefination1 as  nvarchar(max);
declare @SQLString1 as nvarchar(max);
SET @SQLString1='Insert Into '+@Master+' (Date,Sid,BRId,UserId,Type,IssNo,DSId,PSId) 
values(''' + CONVERT(VARCHAR(10),@Date, 101) + ''',''' + CONVERT(VARCHAR(10),@SId, 101) + ''',''' + CONVERT(VARCHAR(10),@BRId, 101) + ''',
 ''' + CONVERT(VARCHAR(10),@UserId, 101) + ''',''' + CONVERT(VARCHAR(10),@Type,101) + ''',''' + CONVERT(VARCHAR(10),@IssNo,101) + ''',''' + CONVERT(VARCHAR(10),@DSId, 101) + ''',''' + CONVERT(VARCHAR(10),@PSId, 101) + ''')
  Select @IssId = Scope_Identity()'
Set @ParamDefination1=N'@IssId int OUTPUT'
exec sp_executesql @SQLString1,@ParamDefination1,@IssId=@IssId OUTPUT
if @IssId > 0
begin
declare @SQLString2 as nvarchar(max);
Declare @ParamDefination2 as  nvarchar(max);
SET @SQLString2='Insert Into '+@Detail+' (IssId,ItemId,Unit,Rate,Qty,Amount) 
SELECT 
''' + CONVERT(VARCHAR(10),@IssId, 101) + ''',
 myXML.value(''./@ItemId'',''int''),myXML.value(''./@UId'',''int''),myXML.value(''./@Rate'',''decimal(18,2)''),
myXML.value(''./@Qty'', ''decimal (18,2)''),myXML.value(''./@Amount'', ''decimal (18,2)'') FROM @XML.nodes(''/doc/title'') As nodes(myXML)'
Set @ParamDefination2=N'@XML xml OUTPUT'
exec sp_executesql @SQLString2,@ParamDefination2,@XML=@XML OUTPUT

    SET NOCOUNT OFF;
end

--insert into Warehouse_Store (IssId,Date,ItemId,Unit,Qty,Rate,[Type],SId,BRId)  
--Select @IssId,@Date,myXML.value('./@ItemId', 'int'),myXML.value('./@UId', 'int')
--, myXML.value('./@Qty', 'decimal(18,2)'), myXML.value('./@Rate', 'decimal(18,2)'),'Out',@SId,@BRId
--
--		
--    FROM @XML.nodes('/doc/title') As nodes(myXML);
---- <doc><title
--    SET NOCOUNT OFF;

insert into Warehouse_Store (IssId,Date,ItemId,Unit,Qty,Rate,[Type],SId,BRId)  
Select @IssId,@Date,myXML.value('./@ItemId', 'int'),myXML.value('./@PurUnitId', 'int')
, myXML.value('./@Qty', 'decimal(18,2)') / myXML.value('./@Factor', 'decimal(18,2)'), myXML.value('./@Rate', 'decimal(18,2)') * myXML.value('./@Factor', 'decimal(18,2)'),'Out',@SId,@BRId

		
    FROM @XML.nodes('/doc/title') As nodes(myXML);
-- <doc><title
    SET NOCOUNT OFF;


end

   COMMIT

insert into Warehouse_Branch (IssId,Date,ItemId,Unit,Qty,Rate,[Type],SId,BRId)    
Select @IssId,@Date,myXML.value('./@ItemId', 'int'),myXML.value('./@UId', 'int')
, myXML.value('./@Qty', 'decimal(18,2)'), myXML.value('./@Rate', 'decimal(18,2)'),'In',@SId,@BRId

		
    FROM @XML.nodes('/doc/title') As nodes(myXML);
-- <doc><title
    SET NOCOUNT OFF;

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
--exec uspGetErrorInfo
set @IssId = 0;
END CATCH
select @IssId




