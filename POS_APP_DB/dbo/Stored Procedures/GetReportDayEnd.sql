
CREATE Proc [dbo].[GetReportDayEnd] 
@Date  Datetime
as
select  (select CompanyName from CompanySetup) as Company,(select Address from CompanySetup) as Address,
@Date as Date1,
op.Date,isnull(sum(op.sub_total),0) as GrossAmount,isnull(sum(op.ent),0) as Ent,
isnull(sum(op.tax),0) as Tax,
isnull(sum(op.Discount),0) as Discount,isnull(sum(op.ServiceCharges),0) as ServiceCharges,
isnull(sum(op.ExtraCharges),0) as ExtraCharges,
isnull(sum(op.net_bill),0) as NetSale,
isnull((Select sum(sr.Amount) from PosSaleReturnMaster sr inner join order_Payment o  on sr.orderKey = o.order_Key where o.Date = op.date),0) as SaleReturn,
isnull(sum(op.cash_Sale),0) as Cash,
isnull(sum(op.credit_Sale),0) as Credit,isnull(sum(op.Tip),0) as CreditCardTip,
isnull((Select sum(sa.OpeningAmount) from ShiftAmount sa inner join Shift_Opening so on sa.Z_Number = so.Z_Report_Number where so.opening_Date = op.date),0) as OpeningAmount,
isnull((Select sum(Amount) from CashDrop where Date = op.date),0) as CashDrop,
isnull((Select sum(sa.ClosingAmount) from ShiftAmount sa inner join Shift_Opening so on sa.Z_Number = so.Z_Report_Number where so.opening_Date = op.date),0) as ClosingAmount,
isnull((Select Count(id) from Order_Payment where Date =@Date  and Order_Type = 'DINE IN'),0) as TotalDineInOrders,
isnull((Select Count(id) from Order_Payment where Date =@Date  and Order_Type = 'TAKE AWAY'),0) as TotalTakeAwayOrders,
isnull((Select Count(id) from Order_Payment where Date =@Date  and Order_Type = 'DELIVERY'),0) as TotalDeliveryOrders,
isnull((select sum(sub_total) from Order_Payment where Date = op.Date and Order_Type = 'DINE IN'),0) as DineInOrderAmount,
isnull((select sum(sub_total) from Order_Payment where Date = op.Date and Order_Type = 'TAKE AWAY'),0) as TakeAwayOrderAmount,
isnull((select sum(sub_total) from Order_Payment where Date = op.Date and Order_Type = 'DELIVERY'),0) as DeliveryOrderAmount,
isnull((Select Count(Sid) from POSSaleReturnmaster where Date =@Date  and OrderType = 'DINE IN'),0) as TotalSaleReturnDineInOrders,
isnull((Select Count(Sid) from POSSaleReturnmaster where Date =@Date  and OrderType = 'TAKE AWAY'),0) as TotalSaleReturnTakeAwayOrders,
isnull((Select Count(Sid) from POSSaleReturnmaster where Date =@Date  and OrderType = 'DELIVERY'),0) as TotalSaleReturnDeliveryOrders,
isnull((select sum(Amount) from POSSaleReturnmaster where Date = op.Date and OrderType = 'DINE IN'),0) as SaleReturnDineInOrderAmount,
isnull((select sum(Amount) from POSSaleReturnmaster where Date = op.Date and OrderType = 'TAKE AWAY'),0) as SaleReturnTakeAwayOrderAmount,
isnull((select sum(Amount) from POSSaleReturnmaster where Date = op.Date and OrderType = 'DELIVERY'),0) as SaleReturnDeliveryOrderAmount,
isnull((Select Count(id) from Dine_In_Order where order_Date =@Date  and Order_Type = 'DINE IN' and is_Delete = 1),0) as TotalDineInOrdersDeleted,
isnull((Select Count(id) from Dine_In_Order where order_Date =@Date  and Order_Type = 'TAKE AWAY' and is_Delete = 1),0) as TotalTakeAwayOrdersDeleted,
isnull((Select Count(id) from Dine_In_Order where order_Date =@Date  and Order_Type = 'DELIVERY' and is_Delete = 1),0) as TotalDeliveryOrdersDeleted,
isnull((select sum(price) from Item_Delete where Date = op.Date and Order_Type = 'DINE IN'),0) as TotalDineInOrdersDeletedAmount,
isnull((select sum(price) from Item_Delete where Date = op.Date and Order_Type = 'TAKE AWAY'),0) as TotalTakeAwayOrdersDeletedAmount,
isnull((select sum(price) from Item_Delete where Date = op.Date and Order_Type = 'DELIVERY'),0) as TotalDeliveryOrdersDeletedAmount,

(select isnull(sum(Amount),0) from CustomerLedgerAdvBooking where [Type] = 'D' and BuffetBookingId = 0 and VoucherType = 'Cash' and Vn like 'PAY-%' and Date  =  @Date) as d1,


 isnull(cast (0 as decimal),0) as d2, isnull(cast (0 as decimal),0) as d3, isnull(cast (0 as decimal),0) as d4, isnull(cast (0 as decimal),0) as d5, isnull(cast (0 as decimal),0) as d6, isnull(cast (0 as decimal),0) as d7, isnull(cast (0 as decimal),0) as d8, isnull(cast (0 as decimal),0) as d9, isnull(cast (0 as decimal),0) as d10, isnull(cast (0 as decimal),0) as d11, isnull(cast (0 as decimal),0) as d12,
isnull(cast (0 as decimal),0) as d13, isnull(cast (0 as decimal),0) as d14, isnull(cast (0 as decimal),0) as d15, isnull(cast (0 as decimal),0) as d16, isnull(cast (0 as decimal),0) as d17, isnull(cast (0 as decimal),0) as d18, isnull(cast (0 as decimal),0) as d19, isnull(cast (0 as decimal),0) as d20, isnull(cast (0 as decimal),0) as d21, isnull(cast (0 as decimal),0) as d22, isnull(cast (0 as decimal),0) as d23, isnull(cast (0 as decimal),0) as d24
,isnull((Select sum(cast (sa.Ten as decimal)) from ShiftAmount sa inner join Shift_Opening so on sa.Z_Number = so.Z_Report_Number where so.opening_Date = op.date),0) 
as Ten
,
isnull((Select sum(cast(sa.Twenty as decimal)) from ShiftAmount sa inner join Shift_Opening so on sa.Z_Number = so.Z_Report_Number where so.opening_Date = op.date),0) 
as Twenty,
isnull((Select sum(cast(sa.Fifty as decimal)) from ShiftAmount sa inner join Shift_Opening so on sa.Z_Number = so.Z_Report_Number where so.opening_Date = op.date),0) 
as Fifty,
isnull((Select sum(cast (sa.Hundred as decimal)) from ShiftAmount sa inner join Shift_Opening so on sa.Z_Number = so.Z_Report_Number where so.opening_Date = op.date),0) 
as Hundred,
isnull((Select sum(cast (sa.FiveHundred as decimal)) from ShiftAmount sa inner join Shift_Opening so on sa.Z_Number = so.Z_Report_Number where so.opening_Date = op.date),0) 
as FiveHundred,
isnull((Select sum(cast (sa.Thousands as decimal)) from ShiftAmount sa inner join Shift_Opening so on sa.Z_Number = so.Z_Report_Number where so.opening_Date = op.date),0) 
as Thousands,
isnull((Select sum(cast (sa.FiveThousands as decimal)) from ShiftAmount sa inner join Shift_Opening so on sa.Z_Number = so.Z_Report_Number where so.opening_Date = op.date),0) 
as FiveThousands,
isnull((Select sum(cast (sa.TenThousands as decimal)) from ShiftAmount sa inner join Shift_Opening so on sa.Z_Number = so.Z_Report_Number where so.opening_Date = op.date),0) 
as TenThousands
from Order_Payment op 
where op.Date=@Date
group by op.Date


SELECT DISTINCT D.CAREOF AS Careoff,
(SELECT ISNULL(SUM(DD.DISCOUNT),0) FROM DISCOUNT DD INNER JOIN DINE_IN_ORDER DI ON DI.ORDER_KEY = DD.ORDER_KEY WHERE DI.ACCOUNT_STATUS = 'PAID' AND DD.C_O = D.CAREOF AND DI.ORDER_DATE =@Date) AS Discount 

FROM dISCOUNTSETTING D