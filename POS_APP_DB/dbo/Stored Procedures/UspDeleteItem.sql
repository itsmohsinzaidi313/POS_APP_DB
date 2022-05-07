






CREATE proc [dbo].[UspDeleteItem]--'100'
@ItemId as int
as

Declare @Error as nvarchar(max);
set @Error = 'Transaction Found';
Declare @Item as nvarchar(max);
set @Item='0';
Select @Item=Item from Item where ItemId=@ItemId
if @Item<>'0'
begin

Declare @ItemParlevel as int;
set @ItemParlevel=0;
if @ItemParlevel=0
begin

Declare @ItemOrderConversion as int;
set @ItemOrderConversion=0;
if @ItemOrderConversion=0
begin

Declare @ItemUnit as int;
set @ItemUnit=0;
if @ItemUnit=0
begin

Declare @Count1 as int;
set @Count1=0;
Select @Count1= ItemId from DemandSheetDetail_Store where ItemId=@ItemId
if @Count1=0
begin

Declare @Count2 as int;
set @Count2=0;
Select @Count2= ItemId from DemandSheetDetail_Branch where ItemId=@ItemId
if @Count2=0
begin

Declare @Count3 as int;
set @Count3=0;
Select @Count3= ItemId from InvoiceDetail_CompanyNew where ItemId=@ItemId
if @Count3=0
begin

Declare @Count4 as int;
set @Count4=0;
Select @Count4= ItemId from PurchaseOrderDetail_Store where ItemId=@ItemId
if @Count4=0
begin

Declare @Count5 as int;
set @Count5=0;
Select @Count5= ItemId from GRNDetail where ItemId=@ItemId
if @Count5=0
begin

Declare @Count6 as int;
set @Count6=0;
Select @Count6= ItemId from InvAdjDetail_Branch where ItemId=@ItemId
if @Count6=0
begin

Declare @Count7 as int;
set @Count7=0;
Select @Count7= ItemId from InvAdjDetail_Store where ItemId=@ItemId
if @Count7=0
begin

Declare @Count8 as int;
set @Count8=0;
Select @Count8= ItemId from IssuanceDetail_Store where ItemId=@ItemId
if @Count8=0
begin

Declare @Count9 as int;
set @Count9=0; 
Select @Count9= ItemId from PhysicalStockDetail_Branch where ItemId=@ItemId
if @Count9=0
begin

Declare @Count10 as int;
set @Count10=0;
Select @Count10= ItemId from PurchaseOrderDetail_Store where ItemId=@ItemId
if @Count10=0
begin

Declare @Count11 as int;
set @Count11=0;
Select @Count11= ItemId from WareHouse_Branch where ItemId=@ItemId
if @Count11=0
begin

Declare @Count12 as int;
set @Count12=0;
Select @Count12= ItemId from WareHouse_Store where ItemId=@ItemId
if @Count12=0
begin

Declare @Count13 as decimal(18,2);
set @Count13=0;
select @Count13= isnull(sum(qty),0) from OpenInventoryDetail where ItemId=@ItemId
if @Count13=0.00
begin

Declare @Count14 as int;
set @Count14=0;
Select @Count14= IngredientId from RecipeDetail where IngredientId=@ItemId
if @Count14=0
begin


delete from OpenInventoryDetail  where ItemId=@ItemId
delete from ItemOrderConversion  where ItemId=@ItemId
delete from ItemParLevel  where ItemId=@ItemId
delete from ItemUnit  where ItemId=@ItemId
delete from Item  where ItemId=@ItemId
declare @Cheack as int;
set @Cheack=0;
select @Cheack=count(Item) from Item  where ItemId=@ItemId
if @Cheack=0
begin
set @Error='Item Deleted Successfully'
end



end

end

end

end

end

end

end
end
end

end
end
end
end
end
end
end
end
end
Select @Error ;



