
CREATE proc [dbo].[UspUpdateCategory]

@CId as int,
@Category as nvarchar(50),
@COId as int

as
Declare @IsExist as bit; 
set @IsExist = 0;

select @IsExist = CId from Category where Category = @Category

if @IsExist = 0
begin

update Category
set

Category =@Category,
COId =@COId

where CId = @CId
end

select @IsExist;


