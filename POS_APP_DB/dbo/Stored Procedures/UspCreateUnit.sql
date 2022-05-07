

CREATE Proc [dbo].[UspCreateUnit]
@Unit as nvarchar(50)
as
Declare @UId as  int;
set @UId=0;
Declare @IsExist as bit; 
set @IsExist = 0;

select @IsExist = UId from Unit where Unit = @Unit 

if @IsExist = 0
begin
Insert into Unit(Unit) values (@Unit) Select @UId = Scope_Identity();
end
Select @UId;