CREATE proc [dbo].[UspGetTaxTypeNewOne]--GST
@TaxType as nvarchar(50)
as

select [Type] from Tax_
where TaxType=@TaxType  and IsApplicable=1

