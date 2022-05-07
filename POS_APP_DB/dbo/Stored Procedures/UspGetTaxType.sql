CREATE proc [dbo].[UspGetTaxType]
as

select Id, (TaxType + ' ' + Cast(Tax as nvarchar(10)) + ' %') as TaxType from Tax_
where  IsApplicable=1