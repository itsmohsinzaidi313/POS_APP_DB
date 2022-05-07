CREATE proc [dbo].[UspSelectCategory]
as
select CId,Category,Category.COId,Company.Company from Category
inner join Company on
Company.COId = Category.COId

