CREATE proc [dbo].[ReportProductionBySubCate]--'7/10/2013 12:00:00 AM','7/10/2013 12:00:00 AM','admin','15'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max),
@SubCategoryId as text
as
Declare @ReportName as nvarchar(max);
set @ReportName='Production Report SubCategory wise';
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],@Login as LoginUser,pm.Date,pm.PRNo,@ReportName as ReportName,c.Category,sc.Subcategory,i.Item,
U.Unit as PackingType,
iu.PkFactor as UnitQty,
(Select Distinct(Unit) from unit  where UId=pd.UnitId) as UnitType,
pd.Qty,pd.Rateperpcs
from ProductionMaster pm
inner join ProductionDetail pd on pm.PRId=pd.PRId
inner join Store s on pm.SId=s.SId
inner join Item i on pd.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Split(@SubCategoryId,',') sp on sp.items = sc.SBId
where pm.Date between @From and @To

