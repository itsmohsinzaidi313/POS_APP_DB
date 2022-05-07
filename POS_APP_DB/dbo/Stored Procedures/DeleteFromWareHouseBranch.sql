CREATE proc [dbo].[DeleteFromWareHouseBranch]
@InvAdjId as int
as
Delete from WareHouse_Branch
where InvAdjId=@InvAdjId