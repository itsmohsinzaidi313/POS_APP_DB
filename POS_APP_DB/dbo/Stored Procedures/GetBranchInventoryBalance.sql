

CREATE Proc [dbo].[GetBranchInventoryBalance]
@BRid as int
as

Declare @TableName as nvarchar(50);
Set @TableName='wareHouse_Branch';
declare @Query as nvarchar(max);
set @Query='
Select C.Category,s.Subcategory ,i.Item,(Select Distinct(Unit) from '+@TableName+' where ItemId=i.ItemId  ) as Unit,
(Select (
( Select isnull(Sum(Qty),0) from '+@TableName+' where [Type]=''In'' and ItemId=i.ItemId and BRId=''' + CONVERT(VARCHAR(10),@BRid, 101) + ''' )
 -
( Select isnull(Sum(Qty),0) from '+@TableName+' where [Type]=''Out'' and ItemId=i.ItemId AND BRId=''' + CONVERT(VARCHAR(10),@BRid, 101) + ''' )))as Balance
From Item i 

inner join SubCategory s on i.SBId=s.SBId
inner join Category C  on s.CId=C.CId  '
exec sp_executesql @Query


