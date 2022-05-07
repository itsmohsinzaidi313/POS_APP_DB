CREATE proc [dbo].[uspGetLastPackageAndPcsByItemId]--104
@ItemId as int
as
Declare @Date as datetime;
select @Date = max(gm.Date) from GrnDetail gd 
inner join GrnMaster gm on gd.GRNId = gm.GRNId
where gd.ItemId = @ItemId

select @Date as Date,isnull(gd.PackageId,0) as PackageId,isnull(gd.PcsPerPackage,0) as PcsPerPackage from GrnDetail gd 
inner join GrnMaster gm on gd.GRNId = gm.GRNId
where gd.ItemId = @ItemId and gm.Date = @Date
group by gd.PackageId,gd.PcsPerPackage