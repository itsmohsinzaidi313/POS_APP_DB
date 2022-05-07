CREATE TABLE [dbo].[InvoiceMaster_Company] (
    [InvoiceId]   INT             IDENTITY (1, 1) NOT NULL,
    [Date]        DATETIME        NULL,
    [COId]        INT             NULL,
    [UserId]      INT             NULL,
    [VId]         INT             NULL,
    [InvoiceNo]   VARCHAR (50)    NULL,
    [SId]         INT             NULL,
    [BRId]        INT             NULL,
    [Amount]      DECIMAL (18, 2) NULL,
    [Discount]    DECIMAL (18, 2) NULL,
    [TotalAmount] DECIMAL (18, 2) NULL,
    [GRNId]       INT             NULL,
    [RefrenceNo]  NVARCHAR (50)   NULL,
    [TotalTax]    DECIMAL (18, 2) NULL,
    CONSTRAINT [PK__InvoiceMaster_Ay__2AC04CAA] PRIMARY KEY CLUSTERED ([InvoiceId] ASC),
    CONSTRAINT [FK_InvoiceMaster_Company_Company] FOREIGN KEY ([COId]) REFERENCES [dbo].[Company] ([COId]),
    CONSTRAINT [FK_InvoiceMaster_Company_Vendor] FOREIGN KEY ([VId]) REFERENCES [dbo].[Vendor] ([VId])
);

