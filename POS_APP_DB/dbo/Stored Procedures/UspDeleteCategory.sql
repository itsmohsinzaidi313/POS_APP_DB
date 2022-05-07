CREATE proc [dbo].[UspDeleteCategory]
@CId as int
as
Declare @Error as nvarchar(max);
Declare @Category as nvarchar(max);
set @Category='0';
Select @Category=Category from Category where CId=@CId
if @Category<>'0'
begin
Declare @Subcategory as int;
set @Subcategory=0;
Select @Subcategory= count(CId) from Subcategory where CId=@CId
if @Subcategory=0
begin
delete from Category where CId=@CId
declare @Cheack as nvarchar(max);
set @Cheack='0';
select @Cheack= Category  from Category where CId=@CId
if @Cheack='0'
begin
set @Error='Category Deleted Successfully'
Select @Error
end
end
else
begin
set @Error='Unable To Delete Because Subcategory Exists Against This Category'
Select @Error
end
end
else 
begin
set @Error= 'Category Not found'
Select @Error
end