Create proc [dbo].[DeleteFromWareHouseStore]
@InvAdjId as int
as
Delete from WareHouse_Store
where InvAdjId=@InvAdjId
