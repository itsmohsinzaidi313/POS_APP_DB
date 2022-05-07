CREATE Proc [dbo].[ReportDeptWiseIssuanceReport]--'1/01/2014 12:00:00 AM','6/27/2014 12:00:00 AM','Admin','16'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max),
@DeptId as text
as
Declare @ReportName as nvarchar(max);
set @ReportName='Branch Issuance Department Wise';
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To],@Login as LoginUser,ism.Date,
ism.IssNo,@ReportName as Heading,Un.Unit as Unit,c.Category,sc.Subcategory,i.Item,
U.Unit as PackingType,
iu.RecpFactor as UnitQty,db.DSNo,
(Select Distinct(Unit) from unit  where UId=issd.Unit) as UnitType,
issd.Qty as IssuedQty, 
b.Branch as BranchName,
dp.department_name,
--(Select Cast (isnull(Round(Avg(Rate),2),0)AS DECIMAL (18,2)) from IssuanceDetail_Store where ItemId=i.ItemId ) as UnitPrice
Cast(isnull([dbo].uspGetItemAvgRateFunc(s.SId,i.ItemId,@To,1),0) / (iu.IssFactor) as DECIMAL (18,2)) as Rate
from IssuanceMaster_Store ism 
inner join IssuanceDetail_Store issd on ism.IssId=issd.IssId
inner join Branch b on ism.BRId=b.BRId
inner join DepartmentPos dp on dp.id = ism.DId
left  join DemandSheetMaster_Branch db on db.DSId=issd.DSId
inner join Store s on ism.SId=s.SId
inner join Item i on issd.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.RecpUnit=U.UId
inner join Unit Un on iu.PurUnit=Un.UId
inner join Split(@DeptId,',') sp on sp.items = dp.id
where ism.Date between @From and @To 
--and ism.DSId=db.DSId
group by ism.Date,ism.IssNo,Un.Unit,c.Category,sc.Subcategory,i.Item,
U.Unit,iu.RecpFactor,db.DSNo,issd.Unit,issd.Qty,i.ItemId,b.Branch,dp.department_name,s.SId,iu.IssFactor
order by ism.date asc
