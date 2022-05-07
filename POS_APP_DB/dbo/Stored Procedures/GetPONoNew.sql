
CREATE proc [dbo].[GetPONoNew]
@VId as int
as
select ps.POId,ps.PONo from PurchaseOrderMaster_Store ps
WHERE ps.VId=@VId and
EXISTS
(
select * from PurchaseOrderDetail_Store pd where ps.POId = pd.POId and pd.Status = 0 
)
order by ps.PONo
