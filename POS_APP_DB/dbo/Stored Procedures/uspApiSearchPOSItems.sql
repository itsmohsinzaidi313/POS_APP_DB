
CREATE proc [dbo].[uspApiSearchPOSItems]
@phrase varchar(50)
as
if(ISNUMERIC(@phrase) = 0)
begin
set @phrase = '%' + @phrase + '%'
select top 5 id, codes, (select id from CategoryPOS where category_name = a.category_name) as [category_id], item_name, sale_price, (sale_price * (select tax_amount / 100 from tax where isapplicable = 1) + sale_price) as [tax_price], '1' [quantity], '' [comment] from ItemPOS a where item_name like @phrase and a.is_delete = 0
end
else
begin
	if(@phrase != '')
	begin
		set @phrase = '%' + @phrase + '%'
	end
select top 5 id, codes, (select id from CategoryPOS where category_name = a.category_name) as [category_id], item_name, sale_price, (sale_price * (select tax_amount / 100 from tax where isapplicable = 1) + sale_price) as [tax_price], '1' [quantity], '' [comment] from ItemPOS a where codes like @phrase and a.is_delete = 0
end