create proc [dbo].[UspSelectItemAll]
as
select 
ItemUnit.PkUnit,ItemUnit.PkFactor,ItemUnit.PurUnit,ItemUnit.PurFactor,
ItemUnit.IssUnit,ItemUnit.IssFactor,ItemUnit.RecpUnit,ItemUnit.RecpFactor,
ItemParlevel.Parlevel
from Itemunit
inner join ItemParlevel on
ItemUnit.ItemId=ItemParlevel.ItemId


