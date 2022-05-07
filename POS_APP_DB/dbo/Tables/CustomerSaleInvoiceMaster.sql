CREATE TABLE [dbo].[CustomerSaleInvoiceMaster] (
    [SLId]          INT             IDENTITY (1, 1) NOT NULL,
    [Date]          DATETIME        NULL,
    [CustId]        INT             NULL,
    [SaleInvoiceNo] VARCHAR (50)    NULL,
    [SId]           INT             CONSTRAINT [DF_CustomerSaleInvoiceMaster_SId] DEFAULT ((0)) NULL,
    [BRId]          INT             CONSTRAINT [DF_CustomerSaleInvoiceMaster_BRId] DEFAULT ((0)) NULL,
    [Amount]        DECIMAL (18, 2) NULL,
    [Discount]      DECIMAL (18, 2) NULL,
    [TotalAmount]   DECIMAL (18, 2) NULL,
    [RefrenceNo]    NVARCHAR (50)   NULL,
    [TotalTax]      DECIMAL (18, 2) NULL,
    [is_ob]         BIT             DEFAULT ((0)) NULL
);

