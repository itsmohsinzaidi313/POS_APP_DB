CREATE proc [dbo].[UspGetTax]
@Id as int 
as

select *  from Tax_
where Id=@Id and IsApplicable=1