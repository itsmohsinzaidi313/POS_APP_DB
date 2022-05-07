
CREATE Proc [dbo].[GetProduct]
as

select id as ProductId , item_name as Product from ItemPos where item_name != 'Any' and category_name not like 'Deals%'
order by item_name
