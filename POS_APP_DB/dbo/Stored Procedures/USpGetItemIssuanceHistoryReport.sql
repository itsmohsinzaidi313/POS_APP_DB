
CREATE Proc [dbo].[USpGetItemIssuanceHistoryReport]--35
@ItemId as int
as
select Ism.Date,Ism.IssNo,c.Category,b.Branch as Subcategory,i.Item,
(Select Distinct(Unit) from unit  where UId=isd.Unit) as UnitType,
isd.Qty as ReceivedQty,dsb.DSNo,
isd.Rate as UnitPrice,isd.Amount
 from IssuanceMaster_Store Ism 
inner join IssuanceDetail_Store isd on Ism.IssId=isd.IssId
--inner join InvoiceMaster_Company im on im.GRNId=gd.GRNId
inner join DemandSheetMaster_Branch dsb on Ism.DSId=dsb.DSId
--inner join Vendor v on v.VId=gm.VId
inner join Branch b on Ism.BRId=b.BRId
inner join Item i on isd.ItemId=i.ItemId
inner join Subcategory sc on i.SBId = sc.SBId
inner join Category c on sc.CId=c.CId
inner join ItemUnit iu on i.ItemId=iu.ItemId
where i.ItemId=@ItemId and b.BRId=Ism.BRId
group by  Ism.Date,Ism.IssNo,c.Category,sc.Subcategory,i.Item,b.Branch,
dsb.DSNo,isd.Qty,isd.Rate,isd.Unit,isd.Amount
order by Ism.Date desc






