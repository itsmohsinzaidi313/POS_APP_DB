CREATE proc [dbo].[uspApiGetPOSItems]
@categoryId int
as
select id, codes, @categoryId as [category_id], item_name, sale_price, (sale_price * (select tax_amount / 100 from tax where isapplicable = 1) + sale_price) as [tax_price] from ItemPOS where category_name = (select category_name from CategoryPOS where id = @categoryId) and is_delete = 0