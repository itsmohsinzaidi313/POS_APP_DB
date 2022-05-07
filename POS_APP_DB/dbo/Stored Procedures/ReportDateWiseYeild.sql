
CREATE Proc [dbo].[ReportDateWiseYeild]--'6/27/2013 12:00:00 AM','10/30/2013 12:00:00 AM','Admin'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max)
as
Declare @ReportName as nvarchar(max);
set @ReportName='Yield Report';
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],@Login as LoginUser,brm.Date,brm.BURNo,@ReportName as Report,Un.Unit,c.Category,sc.Subcategory,i.Item,
U.Unit as PackingType,
iu.PurFactor as UnitQty,brd.Rate as UnitRate,
(Select Distinct(Unit) from unit  where UId=brd.Unit) as UnitType,
brd.QTY as YieldQty,
(select (isnull(Round((Qty),2),0)) from IssuanceButcheryDetail) as IssuedQty
--(select Qty from WareHouse_Store where ItemId = i.ItemId and Date = brm.Date ) as IssuedQty
 
from ButcheryReturnMaster brm 
inner join ButcheryReturnDetail brd on brm.BUTRId=brd.BUTRId
inner join Item i on brd.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Unit Un on iu.PurUnit=Un.UId
where brm.Date between @From and @To
group by brm.Date,brm.BURNo,Un.Unit,c.Category,sc.Subcategory,i.Item,U.Unit,
iu.PurFactor,brd.Rate,brd.Unit,brd.QTY ,i.ItemId
order by brm.date asc