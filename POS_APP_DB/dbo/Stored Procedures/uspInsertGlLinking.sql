CREATE proc [dbo].[uspInsertGlLinking]
@CAId as int,
@Type as nvarchar(10),
@Transaction as nvarchar(50),
@Form as nvarchar(50)
as
Declare @Id int;
set @Id = 0;
insert into DiscountMapping (CAId,[Type],[Transaction],Form) values (@CAId,@Type,@Transaction,@Form)
select @Id = scope_identity();
