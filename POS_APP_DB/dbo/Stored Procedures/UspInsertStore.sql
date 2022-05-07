
CREATE proc [dbo].[UspInsertStore]--76,fhdfh,'True'

@COId as int,
@Store as nvarchar(50),
@CentarlStore as nvarchar(50)
as
Declare @SId as  int;
set @SId=0;

Declare @IsExist as bit; 
set @IsExist = 0;

select @IsExist = SId from Store where Store = @Store

if @IsExist = 0
begin
insert into Store
(
COId,
Store,
CentarlStore
)
Values
(
@COId,
@Store,
@CentarlStore
)


select @SId= (select Max (SId) from store)
end
select @SId;