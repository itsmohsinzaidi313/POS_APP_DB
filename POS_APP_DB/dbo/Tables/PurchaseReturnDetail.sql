CREATE TABLE [dbo].[PurchaseReturnDetail] (
    [Id]             INT             IDENTITY (1, 1) NOT NULL,
    [PRId]           INT             NULL,
    [ItemId]         INT             NULL,
    [Unit]           INT             NULL,
    [Rate]           DECIMAL (18, 2) NULL,
    [Qty]            DECIMAL (18, 2) NULL,
    [POId]           INT             NULL,
    [TotalPackage]   DECIMAL (18, 2) NULL,
    [PcsPerPackage]  DECIMAL (18, 2) NULL,
    [RatePerPackage] DECIMAL (18, 2) NULL,
    [PackageId]      INT             NULL,
    [GRNId]          INT             NULL,
    [DSCOId]         INT             NULL,
    [DiscountPerPcs] DECIMAL (18, 2) NULL,
    [TaxPerPcs]      DECIMAL (18, 2) NULL,
    [TaxType]        NVARCHAR (50)   NULL,
    [NetAmount]      DECIMAL (18, 2) NULL,
    [Amount]         DECIMAL (18, 2) NULL,
    [TaxMode]        INT             CONSTRAINT [DF_PurchaseReturnDetail_TaxMode] DEFAULT ((0)) NULL,
    CONSTRAINT [FK_PurchaseReturnDetail_PurchaseReturnMaster] FOREIGN KEY ([PRId]) REFERENCES [dbo].[PurchaseReturnMaster] ([PRId])
);

