
CREATE proc [dbo].[UspUpdateSubCategory]
@SBID as int,
@CId as int,
@SubCategory as nvarchar(50)

as
Declare @IsExist as bit; 
set @IsExist = 0;

select @IsExist = SBId from SubCategory  where SubCategory  = @SubCategory 

if @IsExist = 0
begin

update SubCategory
set

CId=@CId,
SubCategory=@SubCategory

where SBID = @SBID
end

select @IsExist;

