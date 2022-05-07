
CREATE proc [dbo].[UpdateDepartment]
@Did as int,
@BRId as int,
@Department as nvarchar(50),
@COId as int
as

Declare @IsExist as bit; 
set @IsExist = 0;

select @IsExist = id from DepartmentPos where BRId = @BRId and department_name = @Department

if @IsExist = 0
begin
update DepartmentPos set department_name = @Department,BRId = @BRId, COId = @COId where id = @Did
end

select @IsExist;