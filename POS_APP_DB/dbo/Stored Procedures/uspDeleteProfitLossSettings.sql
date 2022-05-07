
create proc [dbo].[uspDeleteProfitLossSettings]

as
delete from ProfitLossSettings

SELECT cOUNT(ID) FROM ProfitLossSettings

