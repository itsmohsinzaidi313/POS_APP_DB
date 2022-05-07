CREATE TABLE [dbo].[InvoiceDetail_CompanyNew] (
    [id]             INT             IDENTITY (1, 1) NOT NULL,
    [InvoiceId]      INT             NULL,
    [ItemId]         INT             NULL,
    [Unit]           INT             NULL,
    [Qty]            DECIMAL (18, 2) NULL,
    [POId]           INT             NULL,
    [GRNId]          INT             NULL,
    [Rate]           DECIMAL (18, 2) NULL,
    [TotalPackage]   DECIMAL (18, 2) NULL,
    [PcsPerPackage]  DECIMAL (18, 2) NULL,
    [RatePerPackage] DECIMAL (18, 2) NULL,
    [PackageId]      INT             NULL,
    [Tax]            DECIMAL (18, 2) CONSTRAINT [DF_InvoiceDetail_CompanyNew_Tax] DEFAULT ((0)) NULL,
    [Discount]       DECIMAL (18, 2) CONSTRAINT [DF_InvoiceDetail_CompanyNew_Discount] DEFAULT ((0)) NULL,
    [Amount]         DECIMAL (18, 2) CONSTRAINT [DF_InvoiceDetail_CompanyNew_Amount] DEFAULT ((0)) NULL,
    [ActualRate]     DECIMAL (18, 2) CONSTRAINT [DF_InvoiceDetail_CompanyNew_ActualRate] DEFAULT ((0)) NULL,
    [TaxType]        NVARCHAR (50)   NULL,
    CONSTRAINT [FK_InvoiceDetail_CompanyNew_GRNMaster] FOREIGN KEY ([GRNId]) REFERENCES [dbo].[GRNMaster] ([GRNId]),
    CONSTRAINT [FK_InvoiceDetail_CompanyNew_InvoiceMaster_CompanyNew] FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[InvoiceMaster_CompanyNew] ([InvoiceId]),
    CONSTRAINT [FK_InvoiceDetail_CompanyNew_Item] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Item] ([ItemId])
);

