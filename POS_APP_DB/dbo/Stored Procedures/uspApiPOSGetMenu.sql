CREATE PROCEDURE [dbo].[uspApiPOSGetMenu]
AS
declare 
	@category xml,
	@items xml,
	@fixedDeals xml,
	@onSpotDeals xml,
	@tax float

	select @tax = (tax_amount / 100) from tax where isApplicable = 1

	select @category = c from (select category_name [@Name], id [@Id] from CategoryPOS for xml path('Category'), root('Categories'), type) as t(c)

	select 
		@items = c from 
			(select 
				id [@Id], 
				codes [@Code], 
				(select id from CategoryPOS where category_name = ItemPOS.category_name) [@CategoryId], 
				item_name [@Name], 
				sale_price [@Price], 
				((sale_price * @tax) + sale_price) as [@TaxAmount], 
				'1' [@Quantity], ' ' [@Comment] 
				from ItemPOS
				where 
					is_delete = 0 and 
					item_name not in((select deal_name from Deals)) and 
					item_name not in((select deal_name from DealsOnSpot)) 
					for xml path('MenuItem'), root('Items'), TYPE) as t(c)

	
	select @fixedDeals = t.c from 
		(select 
			a.Id [@Id], 
			(select id from CategoryPOS where category_name = a.category_name) [@CategoryId],
			a.codes [@Code],
			a.item_name [@Name],
			1 [@Quantity],
			cast(a.sale_price as float) [@Price],
			cast((a.sale_price * @tax) + a.sale_price as float) [@TaxAmount],
			cast(a.sale_price  as float) [@Amount],
			' ' [@Comment],
			(select t1.c1 from 
				(select 
					(select id from ItemPOS where item_name = aa.Item_name and is_delete = 0) [@Id],
					(select codes from ItemPOS where item_name = aa.Item_name and is_delete = 0) [@Code],
					(select id from categorypos where category_name = aa.Category_name) [@CategoryId],
					aa.Item_name [@Name], 
					aa.qty [@Quantity],
					cast((select sale_price from itempos where item_name = aa.item_name) as float) [@Price],
					cast(((@tax * (select sale_price from itempos where item_name = aa.item_name)) + (select sale_price from itempos where item_name = aa.item_name)) as float) [@TaxAmount],
					cast((select sale_price from itempos where item_name = aa.item_name) as float) [@Amount],
					' ' [@Comment]
					from Deals aa where deal_name = a.item_name
					for xml path('MenuItem'), root('Items'), TYPE) as t1(c1))
		from ItemPOS a
		where a.item_name in (select deal_name from Deals) 
		for xml path('FixedDeal'), root('FixedDeals')) as t(c)
	
	select @onSpotDeals = t.c from 
		(select 
			' ' [@UniqueDealId],
			a.Id [@Id], 
			(select id from CategoryPOS where category_name = a.category_name) [@CategoryId],
			a.codes [@Code],
			a.item_name [@Name],
			1 [@Quantity],
			cast(a.sale_price as float) [@Price],
			cast((a.sale_price * @tax) + a.sale_price as float) [@TaxAmount],
			cast(a.sale_price  as float) [@Amount],
			' ' [@Comment],
			(select t1.c1 from 
				(select 
					(select id from ItemPOS where item_name = aa.Item_name and is_delete = 0) [@Id],
					(select codes from ItemPOS where item_name = aa.Item_name and is_delete = 0) [@Code],
					(select id from categorypos where category_name = aa.Category_name) [@CategoryId],
					aa.Item_name [@Name], 
					aa.qty [@Quantity],
					cast((select sale_price from itempos where item_name = aa.item_name) as float) [@Price],
					cast(((@tax * (select sale_price from itempos where item_name = aa.item_name)) + (select sale_price from itempos where item_name = aa.item_name)) as float) [@TaxAmount],
					cast((select sale_price from itempos where item_name = aa.item_name) as float) [@Amount],
					' ' [@Comment],
					cast(dbo.udf_choise_to_number(aa.ChooseAny) as decimal(18,2)) [@Choice]
					from DealsOnSpot aa where deal_name = a.item_name
					for xml path('OnSpotDealItem'), root('DealItems'), TYPE) as t1(c1))
		from ItemPOS a
		where a.item_name in (select deal_name from DealsOnSpot) 
		for xml path('OnSpotDeal'), root('OnSpotDeals')) as t(c)
	
	
	
	select cast(c as xml) from (select @category, @items, @fixedDeals, @onSpotDeals for xml path('Menu')) as t(c)