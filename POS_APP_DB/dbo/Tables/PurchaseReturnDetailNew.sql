CREATE TABLE [dbo].[PurchaseReturnDetailNew] (
    [id]             INT             IDENTITY (1, 1) NOT NULL,
    [PRId]           INT             NULL,
    [ItemId]         INT             NULL,
    [Unit]           INT             NULL,
    [Qty]            DECIMAL (18, 2) NULL,
    [POId]           INT             NULL,
    [Rate]           DECIMAL (18, 2) NULL,
    [TotalPackage]   DECIMAL (18, 2) NULL,
    [PcsPerPackage]  DECIMAL (18, 2) NULL,
    [RatePerPackage] DECIMAL (18, 2) NULL,
    [PackageId]      INT             NULL,
    [Tax]            DECIMAL (18, 2) CONSTRAINT [DF_PurchaseReturnDetailNew_Tax] DEFAULT ((0)) NULL,
    [Discount]       DECIMAL (18, 2) CONSTRAINT [DF_PurchaseReturnDetailNew_Discount] DEFAULT ((0)) NULL,
    [Amount]         DECIMAL (18, 2) CONSTRAINT [DF_PurchaseReturnDetailNew_Amount] DEFAULT ((0)) NULL,
    [ActualRate]     DECIMAL (18, 2) CONSTRAINT [DF_PurchaseReturnDetailNew_ActualRate] DEFAULT ((0)) NULL,
    [TaxType]        NVARCHAR (50)   NULL,
    CONSTRAINT [FK_PurchaseReturnDetailNew_Item] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Item] ([ItemId]),
    CONSTRAINT [FK_PurchaseReturnDetailNew_Store_PurchaseReturnMasterNew_Store] FOREIGN KEY ([PRId]) REFERENCES [dbo].[PurchaseReturnMasterNew] ([PRId])
);

