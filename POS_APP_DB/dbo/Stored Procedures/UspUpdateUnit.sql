
CREATE Proc [dbo].[UspUpdateUnit] 
@UId as int,
@Unit as nvarchar(50)
as

Declare @IsExist as bit; 
set @IsExist = 0;

select @IsExist = UId from Unit where Unit = @Unit

if @IsExist = 0
begin

Update Unit set Unit=@Unit
where UId = @UId 

end
select @IsExist;