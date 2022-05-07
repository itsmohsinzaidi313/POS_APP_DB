CREATE TABLE [dbo].[GRNDetail] (
    [id]             INT             IDENTITY (1, 1) NOT NULL,
    [GRNId]          INT             NULL,
    [ItemId]         INT             NULL,
    [Unit]           INT             NULL,
    [Qty]            DECIMAL (18, 2) NULL,
    [POId]           INT             NULL,
    [Rate]           DECIMAL (18, 2) NULL,
    [TotalPackage]   DECIMAL (18, 2) NULL,
    [PcsPerPackage]  DECIMAL (18, 2) NULL,
    [RatePerPackage] DECIMAL (18, 2) NULL,
    [PackageId]      INT             NULL,
    [Tax]            DECIMAL (18, 2) CONSTRAINT [DF_GRNDetail_Tax] DEFAULT ((0)) NULL,
    [Discount]       DECIMAL (18, 2) CONSTRAINT [DF_GRNDetail_Discount] DEFAULT ((0)) NULL,
    [Amount]         DECIMAL (18, 2) CONSTRAINT [DF_GRNDetail_Amount] DEFAULT ((0)) NULL,
    [ActualRate]     DECIMAL (18, 2) CONSTRAINT [DF_GRNDetail_ActualRate] DEFAULT ((0)) NULL,
    [TaxType]        NVARCHAR (50)   NULL,
    [RatePerPcs]     DECIMAL (18, 2) DEFAULT ((0)) NOT NULL,
    [Qty_Pcs]        DECIMAL (18, 2) DEFAULT ((0)) NULL,
    CONSTRAINT [FK_GRNDetail_Item] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Item] ([ItemId]),
    CONSTRAINT [FK_GRNDetail_Store_GRNMaster_Store] FOREIGN KEY ([GRNId]) REFERENCES [dbo].[GRNMaster] ([GRNId])
);

