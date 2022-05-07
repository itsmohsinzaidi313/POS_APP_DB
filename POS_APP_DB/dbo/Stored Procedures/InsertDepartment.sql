
CREATE proc [dbo].[InsertDepartment]

@Department as nvarchar(50),
@BRId as int,
@COId as int

as
declare @DeptId int;
set @DeptId = 0;

Declare @IsExist as bit; 
set @IsExist = 0;

select @IsExist = id from DepartmentPos where BRId = @BRId and department_name = @Department

if @IsExist = 0
begin

insert into DepartmentPos (department_name,BRId,COId) 
values					  (@Department,@BRId,@COId)
select @DeptId = scope_identity();
end

select @DeptId;