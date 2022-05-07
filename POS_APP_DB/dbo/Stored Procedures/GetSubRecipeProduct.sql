

CREATE Proc [dbo].[GetSubRecipeProduct]
as
Select ItemId as ProductId,i.Item as Product from Item i
inner join SubCategory sb on i.SBId=sb.SBId where sb.Subcategory like 'Sub%'
order by i.Item
