

CREATE proc [dbo].[UspUpdatebranch]--55,78,'aa',0

@BRId as int,
@COId as int,
@Branch as nvarchar(50),
@IsPosSelected as bit
as

Declare @IsExist as bit; 
set @IsExist = 0;

select @IsExist = BRId from Branch where Branch = @Branch and COId = @COId and IsPosSelected = @IsPosSelected

if @IsExist = 0
begin

if cast(@IsPosSelected as bit) = 1
begin
update Branch set IsPosSelected = 0;
end

update Branch
set
COId=@COId,
Branch=@Branch,
IsPosSelected =@IsPosSelected 

where BRId =@BRId
end
select @IsExist;
