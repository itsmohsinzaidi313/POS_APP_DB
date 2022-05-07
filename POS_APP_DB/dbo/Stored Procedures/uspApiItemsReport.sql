
CREATE proc [dbo].[uspApiItemsReport]
@fromDate varchar(10),
@toDate varchar(10),
@shift varchar(10),
@topSale bit
as
begin try
if(@shift = '')
begin
	if(@topSale = 0)
	begin
		print('not top sale item not shift')
		select sum(qty) [quantity], item_name [item], sum(pricebeforediscount) [amount], (select order_type from Dine_In_Order where Dine_In_Order.order_key = order_key) [orderType] from Order_Detail where cast([date] as date) between  cast(@fromDate as date) and cast(@toDate as date) group by item_name
	end
	else
	begin
		print('top sale item not shift')	
		select sum(qty) [quantity], item_name [item], sum(pricebeforediscount) [amount], (select order_type from Dine_In_Order where Dine_In_Order.order_key = order_key) [orderType] from Order_Detail where cast([date] as date) between  cast(@fromDate as date) and cast(@toDate as date) group by item_name order by [quantity] desc
	end

end
else
begin
	if(@topSale = 0)
	begin
		print('not top sale item shift')
		select sum(qty) [quantity], item_name [item], sum(pricebeforediscount) [amount], (select order_type from Dine_In_Order where Dine_In_Order.order_key = order_key) [orderType] from Order_Detail where cast([date] as date) between  cast(@fromDate as date) and cast(@toDate as date) and z_number = @shift group by item_name
	end
	else
	begin
	print('top sale item shift')
		select sum(qty) [quantity], item_name [item], sum(pricebeforediscount) [amount], (select order_type from Dine_In_Order where Dine_In_Order.order_key = order_key) [orderType] from Order_Detail where cast([date] as date) between  cast(@fromDate as date) and cast(@toDate as date) and z_number = @shift group by item_name order by [quantity] desc
	end
end

end try
begin catch
print error_line()
print error_message()
select -1
end catch
