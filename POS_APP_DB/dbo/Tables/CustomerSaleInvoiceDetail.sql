CREATE TABLE [dbo].[CustomerSaleInvoiceDetail] (
    [id]             INT             IDENTITY (1, 1) NOT NULL,
    [SLId]           INT             NULL,
    [ItemId]         INT             NULL,
    [Unit]           INT             NULL,
    [Qty]            DECIMAL (18, 2) NULL,
    [Rate]           DECIMAL (18, 2) NULL,
    [TotalPackage]   DECIMAL (18, 2) NULL,
    [PcsPerPackage]  DECIMAL (18, 2) NULL,
    [RatePerPackage] DECIMAL (18, 2) NULL,
    [PackageId]      INT             NULL,
    [Tax]            DECIMAL (18, 2) CONSTRAINT [DF_CustomerSaleInvoiceDetail_Tax] DEFAULT ((0)) NULL,
    [Discount]       DECIMAL (18, 2) CONSTRAINT [DF_CustomerSaleInvoiceDetail_Discount] DEFAULT ((0)) NULL,
    [Amount]         DECIMAL (18, 2) CONSTRAINT [DF_CustomerSaleInvoiceDetail_Amount] DEFAULT ((0)) NULL,
    [ActualRate]     DECIMAL (18, 2) CONSTRAINT [DF_CustomerSaleInvoiceDetail_ActualRate] DEFAULT ((0)) NULL,
    [TaxType]        NVARCHAR (50)   NULL
);

