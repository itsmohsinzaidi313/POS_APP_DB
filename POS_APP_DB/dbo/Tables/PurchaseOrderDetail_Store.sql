CREATE TABLE [dbo].[PurchaseOrderDetail_Store] (
    [id]     INT             IDENTITY (1, 1) NOT NULL,
    [POId]   INT             NULL,
    [ItemId] INT             NULL,
    [UId]    INT             NULL,
    [Rate]   DECIMAL (18, 2) NULL,
    [Amount] DECIMAL (18, 2) NULL,
    [Qty]    DECIMAL (18, 2) NULL,
    [DSCOId] INT             NULL,
    [Status] BIT             CONSTRAINT [DF__PurchaseO__Statu__28D80438] DEFAULT ((0)) NULL,
    [RecQty] DECIMAL (18, 2) CONSTRAINT [DF_PurchaseOrderDetail_Store_RecQty] DEFAULT ((0)) NULL
);


GO




create TRIGGER [trgPurchaseOrderStatus] ON [dbo].[PurchaseOrderDetail_Store]
FOR UPDATE
AS
Declare @Id int;
set @Id = 0;
Declare @Qty as decimal(18,2);
set @Qty = 0;
Declare @RecQty as decimal(18,2);
set @RecQty = 0;

select @Id=i.id from inserted i; 

if (@Id > 0)
begin
select @Qty = Qty,@RecQty = RecQty from PurchaseOrderDetail_Store where id = @Id

if (@RecQty >= @Qty)
begin
update PurchaseOrderDetail_Store set Status = 1 where id = @Id
end
else 
begin
update PurchaseOrderDetail_Store set Status = 0 where id = @Id

end
end


