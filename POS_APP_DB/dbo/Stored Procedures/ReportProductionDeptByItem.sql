
CREATE proc [dbo].[ReportProductionDeptByItem]--'7/01/2014 12:00:00 AM','7/10/2014 12:00:00 AM','admin','137'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max),
@ItemId as text
as
Declare @ReportName as nvarchar(max);
set @ReportName='Department Production Report Item wise';
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],@Login as LoginUser,pm.Date,pm.PRNo,@ReportName as ReportName,c.Category,sc.Subcategory,i.Item,
U.Unit as PackingType,
iu.PkFactor as UnitQty,
(Select Distinct(Unit) from unit  where UId=pd.UnitId) as UnitType,
pd.Qty,pd.Rateperpcs
from ProductionMasterDepartment pm
inner join ProductionDetailDepartment pd on pm.PRId=pd.PRId
inner join Store s on pm.SId=s.SId
inner join Item i on pd.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Split(@ItemId,',') sp on sp.items = i.ItemId
where pm.Date between @From and @To

