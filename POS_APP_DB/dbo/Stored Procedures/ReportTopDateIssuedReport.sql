
CREATE Proc [dbo].[ReportTopDateIssuedReport]--'7/1/2013 12:00:00 AM','9/30/2013 12:00:00 AM' ,'Admin'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max)
as
Declare @ReportName as nvarchar(max);
set @ReportName='Top All Issued Item';
select isnull(sum(ids.Qty),0) as IssueQty,  CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106) as [To], 
@Login as LoginUser,b.Branch,c.Category,sc.Subcategory,i.Item,i.ItemId,
U.Unit as PackingType,@ReportName as ReportName,
iu.PkFactor as UnitQty,Cast(isnull(Round(avg(ids.Rate),2),0) AS DECIMAL (18,2))  as Rate,
(Select Distinct(Unit) from unit  where UId=ids.Unit) as UnitType
--ipl.ParLevel
 from IssuanceMaster_Store im 
inner join IssuanceDetail_Store ids on im.IssId=ids.IssId
--inner join Vendor v on v.VId=im.VId
inner join Branch b on im.BRId=b.BRId
inner join Item i on ids.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
--inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join Unit U on iu.IssUnit=U.UId
where im.Date between @From and @To 
--and  ipl.BRId>0 and ipl.SId=0 
--and im.BRId = b.BRId
group by b.Branch ,c.Category,sc.Subcategory,i.Item,i.ItemId,
U.Unit,
iu.PkFactor,ids.unit 
--ipl.ParLevel
,ids.Qty
order by ids.Qty desc



















