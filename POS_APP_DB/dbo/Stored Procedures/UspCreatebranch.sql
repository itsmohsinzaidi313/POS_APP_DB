
CREATE proc [dbo].[UspCreatebranch]

@COId as int,
@Branch as nvarchar(50),
@IsPosSelected as bit

as
Declare @BRId as int;
set @BRId = 0;
Declare @IsExist as bit; 
set @IsExist = 0;

select @IsExist = BRId from Branch where Branch = @Branch

if @IsExist = 0
begin
insert into Branch
(
COID,
Branch,
IsPosSelected
)
values
(
@COId,
@Branch,
@IsPosSelected
)

select @BRId= (select Max (BRId) from Branch)
end
select @BRId;