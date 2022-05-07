CREATE TABLE [dbo].[InvoiceMaster_CompanyNew] (
    [InvoiceId]   INT             IDENTITY (1, 1) NOT NULL,
    [Date]        DATETIME        NULL,
    [VId]         INT             NULL,
    [InvoiceNo]   VARCHAR (50)    NULL,
    [SId]         INT             CONSTRAINT [DF_InvoiceMaster_CompanyNew_SId] DEFAULT ((0)) NULL,
    [BRId]        INT             CONSTRAINT [DF_InvoiceMaster_CompanyNew_BRId] DEFAULT ((0)) NULL,
    [Amount]      DECIMAL (18, 2) NULL,
    [Discount]    DECIMAL (18, 2) NULL,
    [TotalAmount] DECIMAL (18, 2) NULL,
    [RefrenceNo]  NVARCHAR (50)   NULL,
    [TotalTax]    DECIMAL (18, 2) NULL,
    CONSTRAINT [PK__InvoiceMaster_CompanyNew_Aylant__3449B6E4] PRIMARY KEY CLUSTERED ([InvoiceId] ASC),
    CONSTRAINT [FK_InvoiceMaster_CompanyNew_Vendor] FOREIGN KEY ([VId]) REFERENCES [dbo].[Vendor] ([VId])
);

