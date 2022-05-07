CREATE proc [dbo].[uspCheckItemInStoreTables]

@ItemId as int,
@SId as int

as
Declare @Error as nvarchar(max);
set @Error = 'Transaction Found';

Declare @Store as nvarchar(max);
set @Store='0';
Select @Store=store from store where Sid=@Sid
Declare @Company as nvarchar(max);
Select @Company=C.company from store s inner join Branch b on s.BRId=b.BRId inner join Company C on b.COId=C.COId where Sid=@Sid
Declare @DemandSheetDetail as nvarchar(max);
set @DemandSheetDetail='DemandSheetDetail_Store';
Declare @GRNDetail as nvarchar(max);
set @GRNDetail='GRNDetail_Store';
Declare @InvAdjDetail as nvarchar(max);
set @InvAdjDetail='InvAdjDetail_Store';
Declare @IssuanceDetail as nvarchar(max);
set @IssuanceDetail='IssuanceDetail_Store';
Declare @WareHouse as nvarchar(max);
set @WareHouse='WareHouse_Store';

if @Store<>'0'
begin

Declare @Count1 as int;
set @Count1=0;
Declare @ParamDef1 as  nvarchar(max);
declare @SQLString1 as nvarchar(max);
SET @SQLString1='Select @Count1= id from '+@DemandSheetDetail+' where ItemId = '+@ItemId+''
Set @ParamDef1=N'@Count1 int OUTPUT'
exec sp_executesql @SQLString1,@ParamDef1,@Count1=@Count1 OUTPUT
if @Count1=0
Begin

Declare @Count3 as int;
set @Count3=0;
Declare @ParamDef3 as  nvarchar(max);
declare @SQLString3 as nvarchar(max);
SET @SQLString3='Select @Count3= id from '+@GRNDetail+' where ItemId = '+@ItemId+''
Set @ParamDef3=N'@Count3 int OUTPUT'
exec sp_executesql @SQLString3,@ParamDef3,@Count3=@Count3 OUTPUT
if @Count3=0
begin

Declare @Count5 as int;
set @Count5=0;
Declare @ParamDef5 as  nvarchar(max);
declare @SQLString5 as nvarchar(max);
SET @SQLString5='Select @Count5= id from '+@InvAdjDetail+' where ItemId = '+@ItemId+''
Set @ParamDef5=N'@Count5 int OUTPUT'
exec sp_executesql @SQLString5,@ParamDef5,@Count5=@Count5 OUTPUT
if @Count5=0
begin

Declare @Count7 as int;
set @Count7=0;
Declare @ParamDef7 as  nvarchar(max);
declare @SQLString7 as nvarchar(max);
SET @SQLString7='Select @Count7= id from '+@IssuanceDetail+' where ItemId = '+@ItemId+''
Set @ParamDef7=N'@Count7 int OUTPUT'
exec sp_executesql @SQLString7,@ParamDef7,@Count7=@Count7 OUTPUT
if @Count7=0
begin

Declare @Count8 as int;
set @Count8=0;
Declare @ParamDef8 as  nvarchar(max);
declare @SQLString8 as nvarchar(max);
SET @SQLString8='Select @Count8= id from '+@WareHouse+' where ItemId = '+@ItemId+''
Set @ParamDef8=N'@Count8 int OUTPUT'
exec sp_executesql @SQLString8,@ParamDef8,@Count8=@Count8 OUTPUT
if @Count8=0
Begin
set @Error = 'No Transaction Found';
End
End
End
End
End
End
select @Error;
