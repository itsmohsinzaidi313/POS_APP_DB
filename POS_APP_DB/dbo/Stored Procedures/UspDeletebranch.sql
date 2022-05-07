

CREATE proc [dbo].[UspDeletebranch]
@BRId as int
as
Declare @Error as nvarchar(max);
Declare @Branch as nvarchar(max);
set @Branch='0';
Select @Branch=Branch from Branch where BRId=@BRId
if @Branch<>'0'
begin
Declare @Store as int;
set @Store=0;
--Select @Store= count(BRID) from Store where BRId=@BRId
if @Store=0
begin
Declare @Department as int;
set @Department=0;
Select @Department= count(BRID) from DepartmentPOS where BRId=@BRId
if @Department=0
begin
Declare @WH as int;
set @WH=0;
Select @WH= count(BRID) from WareHouse_Branch where BRId=@BRId
if @WH=0
begin
delete from ItemParLevel where BRId=@BRId
delete from Branch where BRId=@BRId
declare @Cheack as nvarchar(max);
set @Cheack='0';
select @Cheack=Branch from Branch where BRId=@BRId
if @Cheack='0'
begin
set @Error='Branch Deleted Successfully'
Select @Error
end
end
else
begin
set @Error='Unable To Delete Because Transaction Exists Against This Branch'
Select @Error
end
end
else
begin
set @Error='Unable To Delete Because Department Exists Against This Branch'
Select @Error
end
end
else
begin
set @Error='Unable To Delete Because Store Exists Against This Branch'
Select @Error
end
end
else 
begin
set @Error= 'Branch Not found'
Select @Error
end






