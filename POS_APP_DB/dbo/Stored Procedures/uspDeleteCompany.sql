
CREATE proc [dbo].[uspDeleteCompany]
@COId as int
as
Declare @Error as nvarchar(max);
Declare @Company as nvarchar(max);
set @Company='0';
Select @Company=company from Company where COId=@COId
if @Company<>'0'
begin
Declare @UserType as int;
set @UserType=0;
Select @UserType=count(COId) from UserType where COId=@COId
if @UserType=0
begin
Declare @Branch as int;
set @Branch=0;
Select @Branch=count(b.BRId) from Company c inner join Branch b on b.COId=b.COId where c.Coid=@COId
if @Branch=0
begin
Declare @Group as int;
set @Group=0;
Select @Group= count(COId) from [Group] where COId=@COId
if @Group=0
begin
Declare @Store as int;
set @Store=0;
Select @Store= count(COId) from Store where COId=@COId
if @Store=0
begin 
Declare @Vendor as int;
set @Vendor=0;
Select @Vendor= count(COId) from Vendor where COId=@COId
if @Vendor=0
begin
Declare @Category as int;
set @Category=0;
Select @Category= count(COId) from Category where COId=@COId
if @Category=0
begin
Declare @DemandSheetMaster as nvarchar(max);
set @DemandSheetMaster='DemandSheetMaster_Company';
Declare @Count as int;
set @Count=0;
Declare @ParamDef as  nvarchar(max);
declare @SQLString as nvarchar(max);
SET @SQLString='Select @Count= DSCOId from '+@DemandSheetMaster+' '
Set @ParamDef=N'@Count int OUTPUT'
exec sp_executesql @SQLString,@ParamDef,@Count=@Count OUTPUT
if @Count=0
begin
Declare @DemandSheetDetail as nvarchar(max);
set @DemandSheetDetail='DemandSheetDetail_Company';
Declare @Count1 as int;
set @Count1=0;
Declare @ParamDef1 as  nvarchar(max);
declare @SQLString1 as nvarchar(max);
SET @SQLString1='Select @Count1= id from '+@DemandSheetDetail+' '
Set @ParamDef1=N'@Count1 int OUTPUT'
exec sp_executesql @SQLString1,@ParamDef1,@Count1=@Count1 OUTPUT
if @Count1=0
begin
Declare @InvoiceMaster as nvarchar(max);
set @InvoiceMaster='InvoiceMaster_Company';
Declare @Count2 as int;
set @Count2=0;
Declare @ParamDef2 as  nvarchar(max);
declare @SQLString2 as nvarchar(max);
SET @SQLString2='Select @Count2= InvoiceId from '+@InvoiceMaster+' '
Set @ParamDef2=N'@Count2 int OUTPUT'
exec sp_executesql @SQLString2,@ParamDef2,@Count2=@Count2 OUTPUT
if @Count2=0
begin
Declare @InvoiceDetail as nvarchar(max);
set @InvoiceDetail='InvoiceDetail_Company';
Declare @Count3 as int;
set @Count3=0;
Declare @ParamDef3 as  nvarchar(max);
declare @SQLString3 as nvarchar(max);
SET @SQLString3='Select @Count3= id from '+@InvoiceDetail+' '
Set @ParamDef3=N'@Count3 int OUTPUT'
exec sp_executesql @SQLString3,@ParamDef3,@Count3=@Count3 OUTPUT
if @Count3=0
begin
Declare @PurchaseOrderMaster as nvarchar(max);
set @PurchaseOrderMaster='PurchaseOrderMaster_Company';
Declare @Count4 as int;
set @Count4=0;
Declare @ParamDef4 as  nvarchar(max);
declare @SQLString4 as nvarchar(max);
SET @SQLString4='Select @Count4= POId from '+@PurchaseOrderMaster+' '
Set @ParamDef4=N'@Count4 int OUTPUT'
exec sp_executesql @SQLString4,@ParamDef4,@Count4=@Count4 OUTPUT
if @Count4=0
begin
Declare @PurchaseOrderDetail as nvarchar(max);
set @PurchaseOrderDetail='PurchaseOrderDetail_Company';
Declare @Count5 as int;
set @Count5=0;
Declare @ParamDef5 as  nvarchar(max);
declare @SQLString5 as nvarchar(max);
SET @SQLString5='Select @Count5= id from '+@PurchaseOrderDetail+' '
Set @ParamDef5=N'@Count5 int OUTPUT'
exec sp_executesql @SQLString5,@ParamDef5,@Count5=@Count5 OUTPUT
if @Count5=0
begin

delete from Company where COId=@COId

declare @Cheack as nvarchar(max);
set @Cheack='0';
select @Cheack=Company from Company where COId=@COId
if @Cheack='0'
begin
set @Error='Company Deleted Successfully'
Select @Error
end
end
else
begin
set @Error='Unable To Delete Because Transection Against This Company Exist In'
Select @Error
end
end
else
begin
set @Error='Unable To Delete Because Transection Against This Company Exist In'
Select @Error
end
end
else
begin
set @Error='Unable To Delete Because Transection Against This Company Exist In'
Select @Error
end
end
else
begin
set @Error='Unable To Delete Because Transection Against This Company Exist In'
Select @Error
end
end
else
begin
set @Error='Unable To Delete Because Transection Against This Company Exist In'
Select @Error
end
end
else
begin
set @Error='Unable To Delete Because Transection Against This Company Exist In'
Select @Error
end
end
else
begin
set @Error='Unable To Delete Because Category Exists Against This Company'
Select @Error
end
end
else
begin
set @Error='Unable To Delete Because Vendor Exists Against This Company'
Select @Error
end
end
else
begin
set @Error='Unable To Delete Because Store Exists Against This Company'
Select @Error
end
end
else
begin
set @Error='Unable To Delete Because Group Exists Against This Company'
Select @Error
end
end
else
begin
set @Error='Unable To Delete Because Branch Exists Against This Company'
Select @Error
end
end
else 
begin
set @Error= 'Unable To Delete Because UserType Exists Against This Company'
Select @Error
end
end
else 
begin
set @Error= 'Company Not found'
Select @Error
end


