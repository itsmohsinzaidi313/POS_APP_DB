
CREATE Proc [dbo].[ReportItemWiseYeild]--'6/27/2013 12:00:00 AM','7/30/2013 12:00:00 AM','Admin','37,38'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max),
@ItemId as text
as
Declare @ReportName as nvarchar(max);
set @ReportName='Yield Report';
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],@Login as LoginUser,brm.Date,brm.BURNo,@ReportName as Report,Un.Unit,c.Category,sc.Subcategory,i.Item,
U.Unit as PackingType,
iu.PurFactor as UnitQty,brd.Rate as UnitRate,
(Select Distinct(Unit) from unit  where UId=brd.Unit) as UnitType,
brd.QTY as YieldQty, 
(select (isnull(Round((Qty),2),0)) from IssuanceButcheryDetail where ItemId=i.ItemId ) as IssuedQty
--(Select Cast (isnull(Round(Avg(Rate),2),0)AS DECIMAL (18,2)) from IssuanceDetail_Store where ItemId=i.ItemId ) as UnitPrice,
--(Select (isnull(Round((Qty),2),0)) from IssuanceDetail_Store where ItemId=i.ItemId ) as IssuedQty
 from ButcheryReturnMaster brm 
inner join ButcheryReturnDetail brd on brm.BUTRId=brd.BUTRId
--inner join Branch b on ism.BRId=b.BRId
--inner join DemandSheetMaster_Branch db on ism.BRId=b.BRId
--inner join Store s on ism.SId=s.SId
inner join Item i on brd.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Unit Un on iu.PurUnit=Un.UId
inner join Split(@ItemId,',') sp on sp.items = i.ItemId
where brm.Date between @From and @To
order by brm.date asc


















