CREATE proc [dbo].[UspSelectSubCategory]
as
select SBId,Category,SubCategory,Category.CId from Subcategory
inner join Category on
Category.CId=SubCategory.CId



