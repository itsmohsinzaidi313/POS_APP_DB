CREATE proc [dbo].[BindSUbCateAgaintsCate]
@CId as int
as
select SBId,SubCategory,Category.CId  from Subcategory
inner join Category on
Category.CId=SubCategory.CId
where Category.CId =@CId


