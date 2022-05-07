
CREATE Proc [dbo].[ReportIssRNoWiseIssuanceReturn]--'6/27/2013 12:00:00 AM','7/30/2013 12:00:00 AM','Admin','30'
@IssRNoId as nvarchar(50),
@Login as nvarchar(max)
as
Declare @ReportName as nvarchar(max);
set @ReportName='Branch Issuance Return ISSRNo Wise';
select @Login as LoginUser,ism.Date,ism.IssRNo,@ReportName as store,Un.Unit, b.branch,c.Category,sc.Subcategory,i.Item,
U.Unit as PackingType,
iu.PurFactor as UnitQty,
(Select Distinct(Unit) from unit  where UId=issd.Unit) as UnitType,
issd.Qty as ReturnQty, 

(Select Cast (isnull(Round([dbo].uspGetItemAvgRateFunc(s.SId,i.ItemId,null,0),2),0)AS DECIMAL (18,2)) ) as UnitPrice,

(Select (isnull(Round((Qty),2),0)) from IssuanceDetail_Store where ItemId=i.ItemId ) as IssuedQty
 from IssuanceReturnMaster ism 
inner join IssuanceReaturnDetail issd on ism.IssRTId=issd.IssRTId
inner join Branch b on ism.BRId=b.BRId
--inner join DemandSheetMaster_Branch db on ism.BRId=b.BRId
inner join Store s on ism.SId=s.SId
inner join Item i on issd.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Unit Un on iu.PurUnit=Un.UId
inner join Split(@IssRNoId,',') sp on sp.items =ism.IssRTId
--where ism.Date between @From and @To
group by ism.Date,ism.IssRNo,Un.Unit,c.Category,sc.Subcategory,i.Item,
U.Unit,iu.PurFactor,issd.Unit,issd.Qty,i.ItemId,b.branch,s.SId
order by ism.date asc



















