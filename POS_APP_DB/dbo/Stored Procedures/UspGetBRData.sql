
CREATE proc [dbo].[UspGetBRData]--'ISSB-0001'
@ISSBNo as nvarchar(50)
as
select i.ItemId,i.Item ,u.Unit,ids.Unit ,ids.Qty,ids.Rate,
Cast((Round(
ids.Rate*ids.Qty,2)) AS DECIMAL (18,2)) as Amount,
Cast((Round((select isnull(IssFactor,0) from ItemUnit where ItemId = i.ItemId)/
(select isnull(PurFactor,0) from ItemUnit where ItemId = i.ItemId),2)) AS DECIMAL (18,2)) as Factor,
iu.PurUnit as PurUnitId
,(select Unit from Unit where UId = iu.PurUnit) as PurUnit


from IssuanceButcheryMaster ibm

inner join IssuanceButcheryDetail ids 
on ibm.BUTId = ids.BUTId

inner join Item i 
on i.ItemId = ids.ItemId
inner join ItemUnit iu on i.ItemId=iu.ItemId
inner join Unit u 
on u.UId = ids.Unit
inner join Unit un on iu.PurUnit=un.Uid 
where ISSBNo=@ISSBNo
group by
i.ItemId,i.Item ,u.Unit,ids.Unit ,ids.Qty,ids.Rate,iu.PurUnit
