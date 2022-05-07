
CREATE proc [dbo].[UspDeleteTax]

@Id as int
as

Declare @IsExist as bit
set @IsExist = 0;

delete from Tax_ 
where Id=@Id

select @IsExist = id from Tax_ where id = @Id