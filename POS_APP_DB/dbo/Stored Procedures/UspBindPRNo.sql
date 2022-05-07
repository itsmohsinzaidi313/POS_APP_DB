CREATE proc [dbo].[UspBindPRNo]
@From as datetime,
@To as Datetime
as
select PRId,PRNo from PurchaseReturnMaster 
where Date between @From and @To
order by PRNo




