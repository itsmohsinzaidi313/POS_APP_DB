create proc [dbo].[TaxType]
as
select [Type] from Tax_
where IsApplicable ='True'