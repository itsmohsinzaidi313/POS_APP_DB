CREATE proc [dbo].[BindItemAgaintsSubCate]
@SBId as int
as
select ItemId,Item,Subcategory.SBId  from Item
inner join Subcategory on
Subcategory.SBId=Item.SBId
where Subcategory.SBId =@SBId


