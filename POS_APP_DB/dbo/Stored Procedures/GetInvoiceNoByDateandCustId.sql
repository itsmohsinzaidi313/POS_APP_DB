create Proc [dbo].[GetInvoiceNoByDateandCustId]
@DateFrom as datetime,
@DateTo as datetime,
@CustId as int
as
select SaleInvoiceNo,Date  from SaleinvoiceMaster where Date between 
@DateFrom and  @DateTo and CustId =@CustId


