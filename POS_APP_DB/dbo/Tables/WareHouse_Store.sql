CREATE TABLE [dbo].[WareHouse_Store] (
    [id]           INT             IDENTITY (1, 1) NOT NULL,
    [Date]         DATETIME        NULL,
    [ItemId]       INT             NULL,
    [Unit]         INT             CONSTRAINT [DF_WareHouse_Store_Unit] DEFAULT ((0)) NULL,
    [InvoiceId]    INT             CONSTRAINT [DF_WareHouse_Store_InvoiceId] DEFAULT ((0)) NULL,
    [BUTId]        INT             CONSTRAINT [DF_WareHouse_Store_BUTId] DEFAULT ((0)) NULL,
    [IssId]        INT             CONSTRAINT [DF_WareHouse_Store_IssId] DEFAULT ((0)) NULL,
    [TRInId]       INT             CONSTRAINT [DF_WareHouse_Store_TRInId] DEFAULT ((0)) NULL,
    [TROutId]      INT             CONSTRAINT [DF_WareHouse_Store_TROutId] DEFAULT ((0)) NULL,
    [InvAdjId]     INT             CONSTRAINT [DF_WareHouse_Store_InvAdjId] DEFAULT ((0)) NULL,
    [Qty]          DECIMAL (18, 4) NULL,
    [WesQty]       DECIMAL (18, 4) CONSTRAINT [DF_WareHouse_Store_WesQty] DEFAULT ((0)) NULL,
    [Rate]         DECIMAL (18, 2) NULL,
    [Type]         NVARCHAR (50)   NULL,
    [BUTRId]       INT             CONSTRAINT [DF_WareHouse_Store_BUTRId] DEFAULT ((0)) NULL,
    [SId]          INT             NULL,
    [PRId]         INT             CONSTRAINT [DF_WareHouse_Store_PRId] DEFAULT ((0)) NULL,
    [IssRTId]      INT             CONSTRAINT [DF_WareHouse_Store_IssRTId] DEFAULT ((0)) NULL,
    [BRId]         INT             CONSTRAINT [DF_WareHouse_Store_BRId] DEFAULT ((0)) NOT NULL,
    [PDId]         INT             CONSTRAINT [DF_WareHouse_Store_PDId] DEFAULT ((0)) NULL,
    [Desc]         NVARCHAR (50)   NULL,
    [DId]          INT             CONSTRAINT [DF_WareHouse_Store_DId] DEFAULT ((0)) NULL,
    [Amount]       DECIMAL (18, 2) CONSTRAINT [DF_WareHouse_Store_Amount] DEFAULT ((0)) NULL,
    [OpenInvId]    INT             CONSTRAINT [DF_WareHouse_Store_OpenInvId] DEFAULT ((0)) NULL,
    [SLId]         INT             CONSTRAINT [DF_WareHouse_Store_SLId] DEFAULT ((0)) NULL,
    [AvgRate]      DECIMAL (18, 2) CONSTRAINT [DF_WareHouse_Store_AvgRate] DEFAULT ((0)) NOT NULL,
    [AvgRateCalc]  INT             CONSTRAINT [DF_WareHouse_Store_AvgRateCalc] DEFAULT ((0)) NOT NULL,
    [AvgRateMonth] NVARCHAR (50)   NULL,
    [Qty_Pcs]      DECIMAL (18, 2) DEFAULT ((0)) NULL,
    CONSTRAINT [FK_WareHouse_Store_Item] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Item] ([ItemId]),
    CONSTRAINT [FK_WareHouse_Store_Store] FOREIGN KEY ([SId]) REFERENCES [dbo].[Store] ([SId])
);


GO
CREATE TRIGGER [dbo].[InsertWarehouseDesc] ON dbo.WareHouse_Store
   FOR INSERT
AS 
BEGIN

    SET NOCOUNT ON;

Declare @Id int;
Declare @InvoiceId int;
Declare @IssId int;
Declare @TRInId int;
Declare @TROutId int;
Declare @InvAdjId int;
Declare @PdId int;
Declare @BUTId int;
Declare @BUTRId int;
Declare @PRId int;
Declare @IssRTId int;

Declare @TransType nvarchar(50);
set @Id = 0;
set @InvoiceId = 0;
set @IssId = 0;
set @TRInId = 0;
set @TROutId = 0;
set @InvAdjId = 0;
set @PdId = 0;
set @BUTId = 0;
set @BUTRId = 0;
set @PRId = 0;
set @IssRTId = 0;
set @TransType = '0';
select 
 @Id = id,
 @InvoiceId = InvoiceId,
 @IssId = IssId,
 @TRInId = TRInId,
 @TROutId = TROutId,
 @InvAdjId = InvAdjId,
 @PdId = PDId,
@BUTId=BUTId,
@BUTRId=BUTRId,
@PRId=PRId,
@IssRTId=IssRTId

 from Warehouse_Store
where id = (select max(id) from Warehouse_Store)

--if @Id > 0
--Begin

if @InvoiceId > 0
Begin
set @TransType = 'Purchase';
Update Warehouse_Store set [Desc] = @TransType where InvoiceId = @InvoiceId

End
else if @IssId > 0
Begin
set @TransType = 'Issuance';
Update Warehouse_Store set [Desc] = @TransType where IssId = @IssId

End
else if @TRInId > 0
Begin
set @TransType = 'TransferIn';
Update Warehouse_Store set [Desc] = @TransType where TRInId = @TRInId

End
else if @TROutId > 0
Begin
set @TransType = 'TransferOut';
Update Warehouse_Store set [Desc] = @TransType where TROutId = @TROutId

End
else if @InvAdjId > 0
Begin
set @TransType = 'InvAdj';
Update Warehouse_Store set [Desc] = @TransType where InvAdjId = @InvAdjId

End
else if @PdId > 0
Begin
set @TransType = 'Production';
Update Warehouse_Store set [Desc] = @TransType where PdId = @PdId

End

else if @BUTId > 0
Begin
set @TransType = 'ButucheryIss';
Update Warehouse_Store set [Desc] = @TransType where BUTId = @BUTId

End
else if @BUTRId > 0
Begin
set @TransType = 'ButucheryRT';
Update Warehouse_Store set [Desc] = @TransType where BUTRId = @BUTRId

End
else if @PRId > 0
Begin
set @TransType = 'PurchaseRT';
Update Warehouse_Store set [Desc] = @TransType where PRId = @PRId

End

else if @IssRTId > 0
Begin
set @TransType = 'IssuanceRT';
Update Warehouse_Store set [Desc] = @TransType where IssRTId = @IssRTId

End
End

--END
