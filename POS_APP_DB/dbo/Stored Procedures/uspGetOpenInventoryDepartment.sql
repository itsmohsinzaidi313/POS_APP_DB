
CREATE Proc [dbo].[uspGetOpenInventoryDepartment]
@BRId as int,
@DeptId as int
as

Declare @OpenInvId int ;
select @OpenInvId = max(OpenInvId) from OpenInventoryMaster_Department where Did = @DeptId

Select i.ItemId,i.Item,u.Unit,u.UId,
Cast(Round((Select (
( Select isnull(Sum(Qty),0) from WareHouse_Branch where [Type]='In' and ItemId=i.ItemId and BRId=@BRId and DId = @DeptId and OpenInvId > 0)
 -
(0))

),2) AS DECIMAL (18,2))as [OpenBalance],

Cast(Round((Select (
(select isnull(avg(Rate) ,0)from WareHouse_Branch where ItemId = i.ItemId and BRId=@BRId and DId = @DeptId))
),2) AS DECIMAL (18,2))as RatePerPcs,
cast(0 as decimal(18,2)) as Amount,

isnull((Select distinct(OpenInvId) from WareHouse_Branch where OpenInvId > 0 and DId = @DeptId and  OpenInvId = (select max(OpenInvId) from  WareHouse_Branch 
)),0)
as OpenInvId
From Item i 
inner join ItemParLevel ipl on i.ItemId=ipl.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u on iu.IssUnit=u.Uid 
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
where ipl.SId=0 and ipl.BRId=@BRId and ipl.DId = @DeptId and i.[Type]='Non Butchery'and sc.SubCategory<>'Sub Recipe'
order by i.Item 
