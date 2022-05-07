


CREATE Proc [dbo].[GetdepartmentInventoryBalanceOfSubRecipeItem]
@Did as int
as
Select i.ItemId,i.Item,u.Unit,u.UId,ipl.Parlevel,
cast((Select
left(
(Select isnull(Sum(Qty),0) from WareHouse_branch where [Type]='In' and ItemId=i.ItemId and DId=@Did)
 -
(Select isnull(Sum(Qty),0) from WareHouse_branch where [Type]='Out' and ItemId=i.ItemId  and DId=@Did ),
len((Select isnull(Sum(Qty),0) from WareHouse_branch where [Type]='In' and ItemId=i.ItemId and DId=@Did)
 -
(Select isnull(Sum(Qty),0) from WareHouse_branch where [Type]='Out' and ItemId=i.ItemId  and DId=@Did))-2
)) as decimal(18,2))as Balance,

(isnull((select avg(Rate) from WareHouse_branch where ItemId=i.ItemId and DId=@Did),0)) as Rate,
iu.IssFactor as Factor
From Item i 
inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.PurUnit=u.Uid 
inner join SubCategory s on i.SBId=s.SBID
where 
ipl.Did = @Did and s.SubCategory like 'Sub%'
group by i.ItemId,i.Item,u.Unit,u.UId,ipl.Parlevel,iu.IssFactor
order by i.Item






