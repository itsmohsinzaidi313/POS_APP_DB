
CREATE proc [dbo].[DeleteDepartment]
@Did as int
as
Declare @IsExist as bit;
set @IsExist = 0;

select @IsExist = DId from DemandSheetMaster_Branch where DId = @Did
if @IsExist = 0
begin
select @IsExist = DId from WareHouse_Store where DId = @Did
if @IsExist = 0
begin
delete from ItemParLevel where DId = @Did
delete from DepartmentPos where id = @Did
end
end
select @IsExist