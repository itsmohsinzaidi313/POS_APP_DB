

CREATE proc [dbo].[uspInsertInvoiceMaster]--'04/11/14 12:00 AM','32','INV-0001',142,0,1000,0,1000,'1',0,'269,'
@Date as datetime,
@VId as int,
@InvoiceNo as nvarchar(10),
@SId as int,
@BRId as int,
@Amount as decimal(18,2),
@Discount as decimal(18,2),
@TotalAmount as decimal(18,2),
@RefNo as nvarchar(50),
@TotalTax as decimal(18,2),
@GRNId as text

as

Declare @InvoiceId as int ;
set @InvoiceId = 0;

insert into InvoiceMaster_CompanyNew 
(
Date,VId,InvoiceNo,SId,BRId,Amount,Discount,TotalAmount,RefrenceNo,TotalTax
) 
values
(
@Date ,@VId ,@InvoiceNo ,@SId ,@BRId ,@Amount ,@Discount ,@TotalAmount ,@RefNo ,@TotalTax 
)
set @InvoiceId = scope_identity();

if @InvoiceId > 0
Begin
Insert into InvoiceDetail_CompanyNew
(
InvoiceId,ItemId,Unit,Qty,POId,GRNId,Rate,TotalPackage,PcsPerPackage,RatePerPackage,PackageId,Tax,Discount,Amount,ActualRate,TaxType
)
select @InvoiceId,gd.ItemId,gd.Unit,gd.Qty,gd.POId,gd.GRNId,gd.Rate,gd.TotalPackage,gd.PcsPerPackage,gd.RatePerPackage,gd.PackageId,
gd.Tax,gd.Discount,gd.Amount,gd.ActualRate,gd.TaxType
from GRNDetail gd
inner join Split(@GRNId,',') sp on sp.items = gd.GRNId


--TempTableWork
DECLARE @TEMPNEWMAP TABLE
(
	TransId  int null,
	[Type] nvarchar(10),
	VN  nvarchar(10),
	Date datetime,
	AccId nvarchar(50),
	AccType nvarchar(50),
	Amount decimal (18,2) null,
	Account nvarchar(50),
	DetailId int null,
    CAId int null,
	COId int null
)
--
Declare @TaxType as nvarchar(50);
Declare @MapId as int;
set @MapId = 0;

Select @MapId = id from DiscountMapping where [Transaction] = 'STOCK'
if @MapId >0
begin 

Insert into @TEMPNEWMAP (TransId,[Type],VN,Date,AccId,AccType,Amount,Account,DetailId,CAId,COId)
Select '0',dm.[TYPE],@InvoiceNo,@Date,ca.AccNo,ca.AccNature,@TotalAmount,ca.AccName,@InvoiceId,dm.CAId,ca.COId
from DiscountMapping dm
inner Join ChartOfAccount ca on ca.CAId=dm.CAId
where [Transaction]='STOCK'


Insert into @TEMPNEWMAP (TransId,[Type],VN,Date,AccId,AccType,Amount,Account,DetailId,CAId,COId)
select '0','C',@InvoiceNo,@Date,ca.AccNo,ca.AccNature,@TotalAmount,ca.AccName,@InvoiceId,v.CAId,ca.COId 
from Vendor v inner join InvoiceMaster_CompanyNew icm on
v.VId = icm.VId
inner Join ChartOfAccount ca on v.CAId=ca.CAId where icm.InvoiceId = @InvoiceId
group by v.CAId,ca.AccNo,ca.AccNature,ca.AccName,ca.COId

end

set @MapId = 0;
Select @MapId = id from DiscountMapping where [Transaction] = 'TAX'
if @MapId >0
begin 

Insert into @TEMPNEWMAP (TransId,[Type],VN,Date,AccId,AccType,Amount,Account,DetailId,CAId,COId)

Select '0',dm.[TYPE],@InvoiceNo,@Date,ca.AccNo,ca.AccNature,@TotalTax,ca.AccName,@InvoiceId,dm.CAId,ca.COId
from DiscountMapping dm
inner Join ChartOfAccount ca on ca.CAId=dm.CAId
where [Transaction]='TAX'


Insert into @TEMPNEWMAP (TransId,[Type],VN,Date,AccId,AccType,Amount,Account,DetailId,CAId,COId)

select '0','C',@InvoiceNo,@Date,ca.AccNo,ca.AccNature,@TotalTax,ca.AccName,@InvoiceId,tx.CAId,ca.COId from Tax_ tx
inner Join ChartOfAccount ca on tx.CAId=ca.CAId
where tx.[Type]=@TaxType
group by tx.CAId,ca.AccNo,ca.AccNature,ca.AccName,ca.COId

end

set @MapId = 0;
Select @MapId = id from DiscountMapping where [Transaction] = 'DISCOUNT'
if @MapId >0
begin 

Insert into @TEMPNEWMAP (TransId,[Type],VN,Date,AccId,AccType,Amount,Account,DetailId,CAId,COId)

Select '0',dm.[TYPE],@InvoiceNo,@Date,ca.AccNo,ca.AccNature,@Discount,ca.AccName,@InvoiceId,dm.CAId,ca.COId
from DiscountMapping dm
inner Join ChartOfAccount ca on ca.CAId=dm.CAId
where dm.[Transaction]='DISCOUNT'
end

--
--
----select * from @TEMPNEWMAP
----EndTempTableWork
insert into GL
(
[Type],
VN,
VoucherId,
Date,
Amount,
CAId,
VoucherType,
COId,
APId
)
select
	[Type] ,
	VN ,
	@InvoiceId,
	Date ,
	Amount ,
	CAId,
	'PURCHASE',
	COId,
	0 
	
from @TEMPNEWMAP

End
select @InvoiceId;
--select * from @TEMPNEWMAP
--Select @MapId


--[uspInsertInvoiceMaster]'04/11/14 12:00 AM','32','INV-0001',142,0,1000,0,1000,'1',0,'269,'

--select * from gl














--select * from gl
--select * from vendor
--
--select * from InvoiceMaster_CompanyNew



