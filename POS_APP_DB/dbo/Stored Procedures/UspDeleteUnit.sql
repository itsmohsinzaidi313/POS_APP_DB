
CREATE Proc [dbo].[UspDeleteUnit] 
@UId as int
as

Declare @IsExist bit;
set @IsExist =  0;

select @IsExist = PkUnit from ItemUnit where PkUnit = @UId

if @IsExist = 0 
begin
select @IsExist = PurUnit from ItemUnit where PurUnit = @UId
if @IsExist = 0 
begin
select @IsExist = IssUnit from ItemUnit where IssUnit = @UId
if @IsExist = 0 
begin
select @IsExist = RecpUnit from ItemUnit where RecpUnit = @UId
if @IsExist = 0 
begin
Delete from Unit where UId = @UId
end
end
end
end
select @IsExist