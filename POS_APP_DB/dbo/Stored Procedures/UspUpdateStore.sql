



CREATE proc [dbo].[UspUpdateStore]

@SId as int,
@COId as int,
@Store as nvarchar(50),
@CentarlStore as nvarchar(50)
as
Declare @IsExist as bit; 
set @IsExist = 0;

select @IsExist = SId from Store where Store = @Store and CentarlStore = @CentarlStore

if @IsExist = 0
begin

if cast(@CentarlStore as bit) = 1
begin
update Store set CentarlStore = 0;
end

update Store
set

COId=@COId,
Store=@Store,
CentarlStore=@CentarlStore

where SId =@SId

end
select @IsExist;
