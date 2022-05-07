
CREATE proc [dbo].[UspInsertCategory]

@Category as nvarchar(50),
@COId as int

as
Declare @CId as  int;
set @CId=0;

Declare @IsExist as bit; 
set @IsExist = 0;

select @IsExist = CId from Category where Category = @Category 

if @IsExist = 0
begin

insert into Category
(

Category ,
COId
)
Values
(
@Category,
@COId
)
select @CId = scope_identity();

end
select @CId;