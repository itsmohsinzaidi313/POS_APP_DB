CREATE Proc [dbo].[ReportItemWiseTransferReportBtB]--'6/27/2013 12:00:00 AM','8/1/2013 12:00:00 AM','Admin','37,38'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max),
@ItemId as text
as
Declare @ReportName as nvarchar(max);
set @ReportName='Transfer Date Wise Branch To Branch';
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106)
 as [To],@Login as LoginUser,Ts.Date,Ts.TRNo,@ReportName as store,Un.Unit
,c.Category,sc.Subcategory,i.Item,
U.Unit as PackingType,
iu.PurFactor as UnitQty,
b.Branch as ToBranch, bb.Branch as FromBranch,
(Select isnull(sum(Qty),0) from WareHouse_Branch  w where [Type]='In'
and w.ItemId=i.ItemId and w.TRInId=Tim.TRIId)as TransferInQty,
(Select isnull(sum(Qty),0) from WareHouse_Branch w where [Type]='Out'
and w.ItemId=i.ItemId and w.TROutId=Tom.TRId)as TransferOutQty,
(Select Distinct(Unit) from unit  where UId=Tid.Unit) as UnitType

from Transfer Ts
inner join TransferInMaster Tim on Tim.TransferId=Ts.TransferId
inner join TransferInDetail Tid on Tim.TRIId=Tid.TRIId
inner join TransferOutMaster Tom on Tom.TransferId=Ts.TransferId
inner join TransferOutDetail Tod on Tod.TRId=Tom.TRId
inner join Branch b on Tim.TRInId=b.BRId
inner join Branch bb on Tom.TROutId=bb.BRId
inner join Item i on Tid.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Unit Un on iu.PurUnit=Un.UId
inner join Split(@ItemId,',') sp on sp.items = i.ItemId
where Ts.Date between @From and @To



















