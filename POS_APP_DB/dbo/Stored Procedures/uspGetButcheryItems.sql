CREATE proc [dbo].[uspGetButcheryItems]
as
select * from Item where [Type] = 'Butchery'
