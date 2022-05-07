CREATE proc [dbo].[uspItemStockReportStoreByDate]

@DateFrom as datetime,
@DateTo as datetime,
@SId as int

as
Declare @ReportName as nvarchar(max);
set @ReportName='Item Stock Date Wise';
Select cat.CId,sub.SBId,
cat.Category,sub.SubCategory,
i.ItemId,i.Item,u.Unit,u.UId,ipl.Parlevel,(Select
(
(Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='In' and ItemId=i.ItemId and SId=@Sid and Date between @DateFrom and @DateTo)
 -
(Select isnull(Sum(Qty),0) from WareHouse_Store where [Type]='Out' and ItemId=i.ItemId  and SId=@Sid and Date between @DateFrom and @DateTo)))as Balance,
(select Cast(isnull(Round(avg(Rate),2),0) AS DECIMAL (18,2)) from WareHouse_Store where ItemId=i.ItemId  and SId=@Sid and Date between @DateFrom and @DateTo) as Rate,
Co.Company,S.Store,Co.COId,S.SId,
@DateFrom as DateFrom, @DateTo as DateTo,@ReportName as ReportName
From Company Co 
inner join Store s on s.COId = Co.COId
inner join Category cat on cat.COId = Co.COId
inner join SubCategory sub on cat.CId = sub.CId
inner join Item i on sub.SBId = i.SBId
inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.PurUnit=u.Uid 
where 
ipl.Sid = @SId and ipl.BRId=0
group by cat.CId,sub.SBId,
cat.Category,sub.SubCategory,i.ItemId,i.Item,u.Unit,u.UId,ipl.Parlevel,Co.Company,S.Store,Co.COId,S.SId
order by i.Item



