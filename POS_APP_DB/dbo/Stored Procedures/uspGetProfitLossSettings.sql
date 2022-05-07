
create proc [dbo].[uspGetProfitLossSettings]
as
select Section,AccNoFrom,AccNoTo,Title from ProfitLossSettings
