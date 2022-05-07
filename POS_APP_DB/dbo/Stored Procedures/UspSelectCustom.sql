create proc [dbo].[UspSelectCustom]
as
select s.CustId,s.Customer,s.Address,s.CellNo,
Company.Coid,Company.Company,s.CAId  from Customer s
inner join Company on
Company.COId=s.COId
 


