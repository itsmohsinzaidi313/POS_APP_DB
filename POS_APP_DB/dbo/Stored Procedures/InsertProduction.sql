CREATE Proc [dbo].[InsertProduction]
@Date as datetime,
@PDNo as nvarchar(50),
@BRID as int,
@SID as int,
@Amount as decimal(18,0),
@XML as xml
as
BEGIN TRY
   BEGIN TRANSACTION  

Declare @PRId as  int;
set @PRId=0;
Declare @Master as nvarchar(max);
Set @Master='ProductionMaster';
Declare @Detail as nvarchar(max)
Set @Detail ='ProductionDetail';
if @PDNo <> '0'
begin 
Declare @ParamDefination1 as  nvarchar(max);
declare @SQLString1 as nvarchar(max);
SET @SQLString1='Insert Into '+@Master+' (Date,PRNo,Sid,Amount) 
values(''' + CONVERT(VARCHAR(10),@Date, 101) + ''',
''' + CONVERT(VARCHAR(10),@PDNo,101) + ''',
''' + CONVERT(VARCHAR(10),@SId, 101) + ''',
''' + CONVERT(VARCHAR(10),@Amount, 101) + ''') Select @PRId = Scope_Identity()'
Set @ParamDefination1=N'@PRId int OUTPUT'
exec sp_executesql @SQLString1,@ParamDefination1,@PRId=@PRId OUTPUT
if @PRId > 0
begin
declare @SQLString2 as nvarchar(max);
Declare @ParamDefination2 as  nvarchar(max);
SET @SQLString2='Insert Into '+@Detail+' (PRId,ItemId,UnitId,Qty,RatePerPcs)
SELECT 
''' + CONVERT(VARCHAR(10),@PRId, 101) + ''',
 myXML.value(''./@ItemId'',''int''),
myXML.value(''./@Unit'',''int''),
myXML.value(''./@Qty'', ''decimal (18,2)''),
myXML.value(''./@Rate'', ''decimal (18,2)'')
FROM @XML.nodes(''/doc/title'') As nodes(myXML)'
Set @ParamDefination2=N'@XML xml OUTPUT'
exec sp_executesql @SQLString2,@ParamDefination2,@XML=@XML OUTPUT
    SET NOCOUNT OFF;
end

--insert into WareHouse_Branch (Date,ItemId,Unit,Qty,Rate,[Type],SId,BRId,PDId)  
--Select @Date,myXML.value('./@ItemId', 'int'),myXML.value('./@Unit', 'int'),
-- myXML.value('./@Qty', 'decimal(18,2)')  / myXML.value('./@Factor', 'decimal(18,2)'),
-- myXML.value('./@Rate', 'decimal(18,2)') * myXML.value('./@Factor', 'decimal(18,2)'),
--'In',@SId,@BRId,@PRId
--
--		
--    FROM @XML.nodes('/doc/title') As nodes(myXML);
---- <doc><title
--    SET NOCOUNT OFF;



end
   COMMIT
END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
    ROLLBACK  -- Roll back
exec uspGetErrorInfo
set @PRId=0;
END CATCH
select @PRId;




