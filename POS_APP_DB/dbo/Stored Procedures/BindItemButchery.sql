
CREATE proc [dbo].[BindItemButchery]
as
select ItemId,Item from Item i
inner join Butchery b on
b.ItemType=i.[Type]
--where b.ItemType ='Butchery'