
CREATE proc [dbo].[UspInsertSubCategory]
@CId as int,
@SubCategory as nvarchar(50)

as
Declare @SBId as  int;
set @SBId=0;

Declare @IsExist as bit; 
set @IsExist = 0;

select @IsExist = SBId from SubCategory where SubCategory = @SubCategory 

if @IsExist = 0
begin

insert into SubCategory
(
CId,
SubCategory 

)
Values
(
@CId,
@SubCategory
)
select @SBId = scope_identity();

end
select @SBId;