
CREATE Proc [dbo].[ApproveInvAdjustmentForStore]--'6/26/2013 12:00:00 AM','0','0','0','0','28','79','<doc><title ItemId="10" Unit="19" Qty="1" Rate="26" Type="In" /><title ItemId="9" Unit="21" Qty="1" Rate="0" Type="Out" /></doc>'
@Date as datetime,
@InvoiceId as int,
@IssId as int,
@TRInId as int,
@TROutId as int,
@InvAdjId as int,
@SId as int,
@XML as xml
as



BEGIN TRY
   BEGIN TRANSACTION  
update InvAdjMaster_Store set IsApprove = 1 where AdjId = @InvAdjId
Declare @Count as int;
set @Count=0;
declare @WareHouse as nvarchar(max);
Set @WareHouse ='WareHouse_Store';
declare @SQLString2 as nvarchar(max);
Declare @ParamDefination2 as  nvarchar(max);
SET @SQLString2='Insert Into '+@WareHouse+' (Date,ItemId,Unit,InvoiceId,IssId,TRInId,TROutId,InvAdjId,Qty,Rate,Type,Sid) 
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
myXML.value(''./@Rate'', ''decimal (18,2)''),myXML.value(''./@Type'', ''nvarchar(50)'') ,

''' + CONVERT(VARCHAR(10),@SId, 101) + '''
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


