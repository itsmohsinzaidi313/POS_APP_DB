CREATE proc [dbo].[UspDeleteGroup]
@GRId as int
as
Declare @Error as nvarchar(max);
Declare @Group as nvarchar(max);
set @Group='0';
Select @Group=[Group] from [Group] where @GRId=@GRId
if @Group<>'0'
begin
Declare @Item as int;
set @Item=0;
Select @Item= count(Itemid) from Item where GRId=@GRId
if @Item=0
begin

delete from [Group] where @GRId=@GRId
declare @Cheack as nvarchar(max);
set @Cheack='0';
select @Cheack=[Group] from [Group] where @GRId=@GRId
if @Cheack='0'
begin
set @Error='Group Deleted Successfully'
Select @Error
end

end
else
begin
set @Error='Unable To Delete Because Item Exists Against This Group'
Select @Error
end
end
else 
begin
set @Error= 'Group Not found'
Select @Error
end


