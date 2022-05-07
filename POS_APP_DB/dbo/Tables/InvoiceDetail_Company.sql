CREATE TABLE [dbo].[InvoiceDetail_Company] (
    [id]             INT             IDENTITY (1, 1) NOT NULL,
    [InvoiceId]      INT             NULL,
    [ItemId]         INT             NULL,
    [Unit]           INT             NULL,
    [Rate]           DECIMAL (18)    NULL,
    [Qty]            DECIMAL (18)    NULL,
    [POId]           INT             NULL,
    [DiscountPerPcs] DECIMAL (18, 2) NULL,
    [TaxPerPcs]      DECIMAL (18, 2) NULL,
    [TotalPackage]   DECIMAL (18, 2) NULL,
    [PcsPerPackage]  DECIMAL (18, 2) NULL,
    [RatePerPackage] DECIMAL (18, 2) NULL,
    [PackageId]      INT             NULL,
    [TaxType]        NVARCHAR (50)   NULL,
    [NetAmount]      DECIMAL (18, 2) NULL,
    [Amount]         DECIMAL (18, 2) NULL,
    [TaxMode]        INT             NULL,
    [GRNId]          INT             CONSTRAINT [DF_InvoiceDetail_Company_GRNId] DEFAULT ((0)) NULL,
    CONSTRAINT [FK_InvoiceDetail_Company_InvoiceMaster_Company] FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[InvoiceMaster_Company] ([InvoiceId]),
    CONSTRAINT [FK_InvoiceDetail_Company_Item] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Item] ([ItemId])
);


GO
CREATE TRIGGER [dbo].[UpdatePurchaseOrderDetailStatus] ON dbo.InvoiceDetail_Company
   FOR INSERT
AS 
BEGIN

    SET NOCOUNT ON;

Declare @ItemId int;
Declare @RecQty decimal(18,2);
Declare @ReqQty decimal(18,2);
Declare @TotalRecQty decimal(18,2);
Declare @POId int;
Declare @Count int;
set @Count = 1;
select 
@ItemId=ItemId,
@POId=POId 
from InvoiceDetail_Company 
where Id = (select max(id) from InvoiceDetail_Company)

select 
@TotalRecQty=isnull(sum(Qty),0)
from InvoiceDetail_Company 
where POId = @POId and ItemId = @ItemId

select @ReqQty = isnull(sum(Qty),0) 
from PurchaseOrderDetail_Store 
where POId = @POId and ItemId = @ItemId

--select @ItemId,@TotalRecQty,@ReqQty,@POId

if @ReqQty = @TotalRecQty
Begin 

Update PurchaseOrderDetail_Store set Status = 1 where POId = @POId and ItemId = @ItemId

End
Else
Begin 

Update PurchaseOrderDetail_Store set Status = 0 where POId = @POId and ItemId = @ItemId

End

select @Count = count(Status) from PurchaseOrderDetail_Store where Status = 0

if @Count = 0
Begin 

Update PurchaseOrderMaster_Store set Status = 1 where POId = @POId 

End
Else 
Begin 

Update PurchaseOrderMaster_Store set Status = 0 where POId = @POId 

End

END
