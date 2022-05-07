
CREATE proc [dbo].[UspDeleteSubCategory]
@SBId as int
as
Declare @Error as nvarchar(max);
Declare @SubCategory as nvarchar(max);
set @SubCategory='0';
Select @SubCategory=SubCategory from SubCategory where SBId=@SBId
if @SubCategory<>'0'
begin
Declare @Item as int;
set @Item=0;
Select @Item= count(SBId) from Item where SBId=@SBId
if @Item=0
begin
delete from SubCategory  where SBId=@SBId
declare @Cheack as nvarchar(max);
set @Cheack='0';
select @Cheack= SubCategory  from SubCategory  where SBId=@SBId
if @Cheack='0'
begin
set @Error='Subcategory Deleted Successfully'
Select @Error
end
end
else
begin
set @Error='Unable To Delete Because Item Exists Against This Subcategory'
Select @Error
end
end
else 
begin
set @Error= 'Subcategory Not found'
Select @Error
end

