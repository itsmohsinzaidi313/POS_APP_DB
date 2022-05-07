CREATE TABLE [dbo].[SaleInvoiceMaster] (
    [SaleInvoiceId] INT             IDENTITY (1, 1) NOT NULL,
    [SaleInvoiceNo] NVARCHAR (40)   NULL,
    [UserId]        INT             NULL,
    [Date]          DATETIME        NULL,
    [Amount]        DECIMAL (18, 2) NULL,
    [Discount]      DECIMAL (18, 2) NULL,
    [TotalAmount]   DECIMAL (18, 2) NULL,
    [IsFixAsset]    BIT             NULL,
    [CustId]        INT             NULL,
    [COId]          INT             NULL,
    [ProId]         INT             CONSTRAINT [DF_SaleInvoiceMaster_ProId] DEFAULT ((0)) NULL
);

