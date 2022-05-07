CREATE Proc [dbo].[GetStoreNameById] 
@CentralStore as int,
@KitchenStore as int,
@COId as int
as

declare @Name as nvarchar(50);
set @Name='';
if @KitchenStore>0
begin 
Select @Name=Branch from Branch where BRId=@KitchenStore and COId=@COId
end
else if @CentralStore>0
begin 
Select @Name=Store from Store where CentarlStore=1 and Sid=@CentralStore and COId=@COId
end
select  @Name;

