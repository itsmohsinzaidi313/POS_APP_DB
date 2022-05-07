CREATE proc [dbo].[UspDeleteStore]--'87'
@SId as int
as
Declare @Store as nvarchar(max);
set @Store='0';
Select @Store=store from store where Sid=@Sid
Declare @Company as nvarchar(max);
Select @Company=C.company from store s inner join Company c on s.COId=c.COId where Sid=@Sid
Declare @DemandSheetMaster as nvarchar(max);
set @DemandSheetMaster='DemandSheetMaster_Store';
Declare @DemandSheetDetail as nvarchar(max);
set @DemandSheetDetail='DemandSheetDetail_Store';
Declare @GRNMaster as nvarchar(max);
set @GRNMaster='GRNMaster';
Declare @GRNDetail as nvarchar(max);
set @GRNDetail='GRNDetail';
Declare @InvAdjMaster as nvarchar(max);
set @InvAdjMaster='InvAdjMaster_Store';
Declare @InvAdjDetail as nvarchar(max);
set @InvAdjDetail='InvAdjDetail_Store';
Declare @IIssuanceMaster as nvarchar(max);                          
set @IIssuanceMaster='IssuanceMaster_Store';
Declare @IssuanceDetail as nvarchar(max);
set @IssuanceDetail='IssuanceDetail_Store';
Declare @WareHouse as nvarchar(max);
set @WareHouse='WareHouse_Store';
Declare @ItemParLevel as nvarchar(max);
set @ItemParLevel='ItemParLevel';
Declare @ChkCount as int;
set @ChkCount = 0;

if @Store<>'0'
begin

Declare @Count as int;
set @Count=0;
Select @Count= SId from DemandSheetMaster_Store where SId = @SId
if @Count=0
begin

Declare @Count1 as int;
set @Count1=0;
if @Count1=0
begin

Declare @Count2 as int;
set @Count2=0;
Select @Count2= SId from GRNMaster where SId = @SId
if @Count2=0
begin

Declare @Count3 as int;
set @Count3=0;
if @Count3=0
begin
Declare @Count4 as int;
set @Count4=0;
Select @Count4= SId from InvAdjMaster_Store where SId = @SId
if @Count4=0
begin

Declare @Count5 as int;
set @Count5=0;
if @Count5=0
begin

Declare @Count6 as int;
set @Count6=0;
Select @Count6= SId from IssuanceMaster_Store where SId = @SId

if @Count6=0
begin

Declare @Count7 as int;
set @Count7=0;
if @Count7=0
begin


Declare @Count8 as int;
set @Count8=0;

Select @Count8= SId from WareHouse_Store where SId = @SId

if @Count8=0
begin

delete from ItemParLevel where SId=@SId
delete from Store where SId=@SId
select @ChkCount = isnull(count(Store),0) from Store where Sid=@Sid

end 
else 
begin
select @ChkCount = isnull(count(Store),0) from Store where Sid=@Sid
end


end 
else 
begin
select @ChkCount = isnull(count(Store),0) from Store where Sid=@Sid
end


end 
else 
begin
select @ChkCount = isnull(count(Store),0) from Store where Sid=@Sid
end


end 
else 
begin
select @ChkCount = isnull(count(Store),0) from Store where Sid=@Sid
end


end 

else 
begin
select @ChkCount = isnull(count(Store),0) from Store where Sid=@Sid
end

end 
else 
begin
select @ChkCount = isnull(count(Store),0) from Store where Sid=@Sid
end

end 
else 
begin
select @ChkCount = isnull(count(Store),0) from Store where Sid=@Sid
end

end 
else 
begin
select @ChkCount = isnull(count(Store),0) from Store where Sid=@Sid
end

end
end
--else
--begin
--print 'Store Not Found'
--end

Declare @Return as nvarchar(50);
Set @Return = 'Transaction Exist, Store not Deleted';

if @ChkCount = 0
Begin
Set @Return = 'Store Deleted Successfully';
End
else
Begin
Set @Return = 'Transaction Exist, Store not Deleted';
End

select @Return;




