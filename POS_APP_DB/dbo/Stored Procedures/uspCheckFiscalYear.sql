
create proc [dbo].[uspCheckFiscalYear]
as
select IsActive from FiscalYear where id = (select max(id) from FiscalYear)
