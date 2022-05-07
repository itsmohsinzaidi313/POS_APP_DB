create proc [dbo].[uspGetGlLinking]
as
select gl.Id,gl.CAId,ca.AccName,gl.[Type],gl.[Transaction],gl.Form
from DiscountMapping gl inner join ChartOfAccount ca on ca.CAId = gl.CAId
