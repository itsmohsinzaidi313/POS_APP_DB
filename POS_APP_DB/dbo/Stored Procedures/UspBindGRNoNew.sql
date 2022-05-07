CREATE proc [dbo].[UspBindGRNoNew]
as
select m.GRNId,m.GRNo as GRNo from GRNMaster m 
where NOT EXISTS
(
select * from InvoiceMaster_Company where GRNId = m.GRNId
)
order by m.GRNo




