create Proc [dbo].[GetNetBalanceOfAccount] --119 ,1
@AccountNo  int,
@COId  int
as
Declare @Return as decimal(18,2)
set @Return = ISNULL([dbo].uspGetNetBalanceFunc(@AccountNo,@COId),0)
Select  @Return

