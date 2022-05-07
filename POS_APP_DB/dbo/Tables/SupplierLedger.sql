CREATE TABLE [dbo].[SupplierLedger] (
    [id]          INT             IDENTITY (1, 1) NOT NULL,
    [VId]         INT             NULL,
    [VoucherId]   INT             NULL,
    [Amount]      DECIMAL (18, 2) NULL,
    [Type]        NVARCHAR (50)   NULL,
    [VoucherType] NVARCHAR (50)   NULL,
    [COId]        INT             NULL,
    [Date]        DATETIME        NULL,
    [VN]          NVARCHAR (50)   NULL,
    [InvoiceId]   INT             CONSTRAINT [DF_SupplierLedger_InvoiceId] DEFAULT ((0)) NULL,
    [IsAdvance]   BIT             CONSTRAINT [DF_SupplierLedger_IsAdvance] DEFAULT ((0)) NULL
);

