

CREATE Proc [dbo].[ReportItemWiseTransferReport]--'5/01/2013 12:00:00 AM','8/1/2014 12:00:00 AM','Admin','98,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,'
@From as datetime,
@To as Datetime,
@Login as nvarchar(max),
@ItemId as text
as
Declare @ReportName as nvarchar(max);
set @ReportName='Report Item Transfer Store To Store';
select CONVERT(VARCHAR(11),@From,106) as [From],CONVERT(VARCHAR(11),@To,106)
 as [To],@Login as LoginUser,Ts.Date,Ts.TRNo,@ReportName as store,Un.Unit
,c.Category,sc.Subcategory,i.Item,
U.Unit as PackingType,
iu.PurFactor as UnitQty,
s.Store as ToStore, ss.Store as FromStore,
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='In'
and w.ItemId=i.ItemId and w.TRInId=Tim.TRIId)as TransferInQty,
(Select isnull(sum(Qty),0) from WareHouse_Store w where [Type]='Out'
and w.ItemId=i.ItemId and w.TROutId=Tom.TRId)as TransferOutQty,
(Select Distinct(Unit) from unit  where UId=Tid.Unit) as UnitType

from Transfer Ts
inner join TransferInMaster Tim on Tim.TransferId=Ts.TransferId
inner join TransferInDetail Tid on Tim.TRIId=Tid.TRIId
inner join TransferOutMaster Tom on Tom.TransferId=Ts.TransferId
inner join TransferOutDetail Tod on Tod.TRId=Tom.TRId
inner join Store s on Tim.TRInId=s.SId
inner join Store ss on Tom.TROutId=ss.SId
inner join Item i on Tid.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit U on iu.PkUnit=U.UId
inner join Unit Un on iu.PurUnit=Un.UId
inner join Split(@ItemId,',') sp on sp.items = i.ItemId
where Ts.Date between @From and @To




















