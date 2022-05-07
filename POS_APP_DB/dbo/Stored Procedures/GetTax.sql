create proc [dbo].[GetTax]
as
select Tax from Tax_
where IsApplicable ='True'