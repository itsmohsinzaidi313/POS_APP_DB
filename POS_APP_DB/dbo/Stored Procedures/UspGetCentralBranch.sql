Create proc [dbo].[UspGetCentralBranch]
as
select IsPosSelected from Branch
where IsPosSelected='True'


