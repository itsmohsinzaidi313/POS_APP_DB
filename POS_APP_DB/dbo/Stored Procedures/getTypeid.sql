create Proc [dbo].[getTypeid]
@id as nvarchar(50)
as
--Select distinct(a.id) from AccountType a 
--inner join ChartOfAccount c 
--on a.[Type] = c.[Type]  
--where c.[Level] = @id
--
--select * from dbo.AccountLevel
--select * from dbo.AccountType

if @id = '3'
Begin
select id from AccountType where [Type] = 'DETAIL'
End
Else if @id = '2'
Begin
select id from AccountType where [Type] = 'SUB GROUP'
End
Else if @id = '1'
Begin
select id from AccountType where [Type] = 'GROUP'
End




