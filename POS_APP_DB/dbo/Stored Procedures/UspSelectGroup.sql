CREATE proc [dbo].[UspSelectGroup]
as
select GRId,[Group],Company.COId,Company.Company from [Group] 
inner join Company on
Company.COId=[Group].COId
