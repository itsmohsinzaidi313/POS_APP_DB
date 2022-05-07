CREATE PROCEDURE [dbo].[uspApiUpdateOnSpotDeals]
	@xml xml
AS

declare
	@orderKey varchar(10),
	@znumber varchar(20),
	@orderDate date,
	@tiltId int,
	@counterId int,
	@tax float

select 
	@orderKey = c.value('@Id','varchar(20)'),
	@counterId = (select top 1 id from ShiftAmount where IsActive = 1 order by id desc),
	@tiltId = c.value('@TiltId','int'),
	@orderDate = c.value('@Date','date'),
	@znumber = (select  z_report_number from Shift_Opening where status = 1),
	@tax = (select  isnull((tax_amount / 100),0.13) from tax where isApplicable = 1)
	from @xml.nodes('Order') as t(c)

print 'inserting onSpotDeal in item_less'
insert into [dbo].[Item_Less]
	([id], [order_key] ,[date] ,[z_num] ,[category] ,[item] ,[qty] ,[price], [server], [order_type], [shift], [tiltId] , [android_detail_id],[is_print], [od_id])
select 
	b.[id], a.[order_key], a.[order_date], a.[z_number], b.[category_name], b.[item_name], b.[qty], b.[price], a.[waiter_name], a.[order_type], GETDATE(), a.[Tiltid], a.[android_device_no], 0, b.id
	from Dine_In_Order a join order_detail b on b.[order_key] = a.[order_key] 
	where	
		a.order_key = @orderKey 
		and item_name in (select deal_name from DealsOnSpot)
		and cast(b.id as varchar(20)) not in (select isnull(t.c.value('@UniqueDealId','varchar(20)'), '0') from @xml.nodes('/Order/OnSpotDeals/OnSpotDeal') as t(c))

print 'inserting onSpotDeal in orderKot'
insert into orderKot
	(orderKey, comments, itemcomment, kotStatus, is_print, orderdetailid, itemid, qty, Tiltid)
select 
	@orderKey, 'LESS', '', 0, 0, b.id, b.ItemId, b.qty, b.tiltId
	from Dine_In_Order a join order_detail b on b.[order_key] = a.[order_key] 
	where	
		a.order_key = @orderKey 
		and item_name in (select deal_name from DealsOnSpot)
		and cast(b.id as varchar(20)) not in (select isnull(t.c.value('@UniqueDealId','varchar(100)'), '0') from @xml.nodes('/Order/OnSpotDeals/OnSpotDeal') as t(c))

print 'deleting osSpotDeal from order_detail'
delete from Order_Detail 
	where 
		order_key = @orderKey 
		and item_name in (select deal_name from DealsOnSpot)
		and cast(id as varchar(20)) not in (select isnull(t.c.value('@UniqueDealId','varchar(100)'), '0') from @xml.nodes('/Order/OnSpotDeals/OnSpotDeal') as t(c))

print 'deleting osSpotDeal from deals_item'
delete from Deals_Item
	where 
		order_key = @orderKey 
		and item_name in (select deal_name from DealsOnSpot)
		and Order_Detail_id not in (select isnull(t.c.value('@UniqueDealId','varchar(100)'), '0') from @xml.nodes('/Order/OnSpotDeals/OnSpotDeal') as t(c))

print 'inserting osSpotDeal from order_detail'
declare
	@dealUniqueId bigint,
	@itemId int,
	@dealName varchar(100),
	@dealQty float,
	@dealPrice float,
	@qtyDiff float,
	@comment varchar(200),
	@orderDetailId varchar(20)

declare cDeal cursor local for select 
	isnull(t.c.value('@UniqueDealId','varchar(100)'), '0'), 
	t.c.value('@Id','int'), t.c.value('@Name','varchar(100)'), 
	t.c.value('@Quantity','float'), t.c.value('@Price','float'), 
	t.c.value('@Comment','varchar(200)') 
	from @xml.nodes('/Order/OnSpotDeals/OnSpotDeal') as t(c)
open cDeal
fetch next from cDeal into @dealUniqueId, @itemId, @dealName, @dealQty, @dealPrice, @comment
while @@FETCH_STATUS != -1
begin
	if(not exists(select id from Order_Detail where id = @dealUniqueId))
	begin
		insert into Order_Detail
			(order_key, date, z_number, category_name, item_name, qty, price, tiltId, CounterId, Discount, PricebeforeDiscount, ItemId, tax, unit)
		select 
			@OrderKey, 
			cast(@orderDate as date), 
			@znumber, 
			(select category_name from CategoryPOS where id = t.c.value('@CategoryId','int')) ,
			t.c.value('@Name','varchar(100)'),
			t.c.value('@Quantity','float'),
			(t.c.value('@Price','float') * t.c.value('@Quantity','float')),
			@tiltId,
			@counterId,
			'0',
			(c.value('@Price','float') * c.value('@Quantity', 'float')), 
			c.value('@Id', 'varchar(50)'),
			((c.value('@Price','float') * c.value('@Quantity', 'float')) * @tax), 
			''
			from @xml.nodes('/Order/OnSpotDeals/OnSpotDeal') as t(c)
			where t.c.value('@UniqueDealId','varchar(100)') = @dealUniqueId

			set @orderDetailId = @@IDENTITY
		insert into DealsOnSpotItems
			(order_key, Order_detailId, deal_name, deal_price, qty, category_name, department, item_name, ItemQty, Price_Item, TiltId)
		select 
			@OrderKey,
			@orderDetailId,
			t.c.value('../../@Name','varchar(100)'),
			(t.c.value('../../@Price','float') * t.c.value('../../@Quantity','float')),
			t.c.value('../../@Quantity','float'),
			(select category_name from CategoryPOS where id = t.c.value('@CategoryId','int')),
			(select department from CategoryPOS where id = t.c.value('@CategoryId','int')),
			t.c.value('@Name','varchar(100)'),
			t.c.value('@Quantity','float') * t.c.value('../../@Quantity','float'),
			(t.c.value('@Price','float') * (t.c.value('@Quantity','float') * t.c.value('../../@Quantity','float'))),
			@tiltId
			from @xml.nodes('/Order/OnSpotDeals/OnSpotDeal/DealItems/OnSpotDealItem') as t(c)
			where t.c.value('../../@UniqueDealId','varchar(100)') = @dealUniqueId

			insert into OrderKot
					(orderkey, ItemId, Qty, KotStatus, is_print, Comments, Tiltid, ItemComment, LessReason, OrderDetailId)
			select
				@OrderKey, @itemId, (select t.c.value('@Quantity','float') from @xml.nodes('/Order/OnSpotDeals/OnSpotDeal') as t(c) where t.c.value('@UniqueDealId','varchar(100)') = @dealUniqueId), 0, 0, 'ADDITIONAL', @tiltId, @comment, '', @orderDetailId
	end
	fetch next from cDeal into @dealUniqueId, @itemId, @dealName, @dealQty, @dealPrice, @comment
end
close cDeal
deallocate cDeal

declare cDeal cursor local for 
	select 
		t.c.value('@UniqueDealId','varchar(20)'),
		t.c.value('@Id','int'),
		t.c.value('@Name','varchar(100)'),
		t.c.value('@Quantity','float'),
		(t.c.value('@Price','float') * t.c.value('@Quantity','float')),
		t.c.value('@Comment','float')
		from @xml.nodes('/Order/OnSpotDeals/OnSpotDeal') as t(c)

open cDeal
fetch next from cDeal into @dealUniqueId, @itemId, @dealName, @dealQty, @dealPrice, @comment

while(@@FETCH_STATUS != -1)
begin
		set @qtyDiff = @dealQty - (select sum(qty) from Order_Detail where id = @dealUniqueId)
		print 'checking quantity difference in onSpotDeals'
		if(@qtyDiff > 0)
		begin
		print 'increasing onSpotDeal quantity'
			print 'inserting onSpotDeal in orderkot as additional'
			insert into OrderKot
				(orderkey, ItemId, Qty, KotStatus, Comments, Tiltid, ItemComment, LessReason, OrderDetailId)
			select
				@OrderKey, @itemId, ABS(@qtyDiff), 0,'ADDITIONAL', @tiltId, @comment, '', @dealUniqueId

			print 'update onSpotDeal in DealsOnSpotItems'

			update a 
				set 
				a.deal_price = @dealPrice, 
				a.qty = @dealQty,
				a.ItemQty = (select ItemQty from DealsOnSpot where deal_name = a.deal_name and item_name = a.item_name) * @dealQty ,
				a.Price_Item = (select sale_price from ItemPOS where item_name = a.item_name) * ((select ItemQty from DealsOnSpot aa where aa.deal_name = a.deal_name and aa.item_name = a.item_name) * @dealQty)
				from DealsOnSpotItems a
				where Order_detailId = @dealUniqueId

			print 'updating onSpotDeal in order_detail'
			update Order_Detail set is_additional = 1 where id = @dealUniqueId
		end
		else if(@qtyDiff < 0)
		begin
			print 'reducing onSpotDeal Quantity'
			print 'inserting onSpotDeal in orderkot as less'
			insert into OrderKot
					(orderkey, ItemId, Qty, KotStatus, is_print, Comments, Tiltid, ItemComment, LessReason, OrderDetailId)
			select
				@OrderKey, @itemId, ABS(@qtyDiff), 0, 0, 'LESS', @tiltId, @comment, '', @dealUniqueId
			print 'inserting onSpotDeal in item_less'
			insert into [dbo].[Item_Less]
				([id], [order_key],[date],[z_num],[category],[item],[qty],[price] ,[server] ,[order_type] ,[shift] ,[tiltId] ,[android_detail_id] ,[is_print], [od_id])
			select 
				a.[order_key], a.[order_key], a.[order_date], a.[z_number], b.[category_name], b.[item_name], ABS(@qtyDiff), (ABS(@qtyDiff) * (price / qty)), a.[waiter_name], a.[order_type], GETDATE(), a.[Tiltid], a.[android_device_no], 0, b.[id]
				from Dine_In_Order a join order_detail b on b.[order_key] = a.[order_key] where b.id = @dealUniqueId

			print 'updating onSpotDeal in DealsOnSpotItems'
			update a 
				set 
				a.deal_price = @dealPrice, 
				a.qty = @dealQty,
				a.ItemQty = (select ItemQty from DealsOnSpot where deal_name = a.deal_name and item_name = a.item_name) * @dealQty ,
				a.Price_Item = (select sale_price from ItemPOS where item_name = a.item_name) * ((select ItemQty from DealsOnSpot aa where aa.deal_name = a.deal_name and aa.item_name = a.item_name) * @dealQty)
				from DealsOnSpotItems a
				where Order_detailId = @dealUniqueId
		end
		if(@qtyDiff != 0)
		begin
			print 'updating onSpotDeal in order_detail'
			update order_detail set qty = @dealQty, price = @dealPrice, tax = (@dealPrice * @tax), PriceBeforeDiscount = @dealPrice where id = @dealUniqueId
			print 'updating onSpotDeal in OrderKot'
			update OrderKot set ItemComment = @comment where OrderDetailId = @dealUniqueId
		end
	fetch next from cDeal into @dealUniqueId, @itemId, @dealName, @dealQty, @dealPrice, @comment
end
close cDeal
deallocate cDeal