CREATE TABLE [dbo].[ReceiptVoucher] (
    [RVId]        INT             IDENTITY (1, 1) NOT NULL,
    [Date]        DATETIME        NULL,
    [CustId]      INT             NULL,
    [Amount]      DECIMAL (18, 2) NULL,
    [ReceiptMode] NVARCHAR (50)   NULL,
    [COId]        INT             NULL,
    [Type]        NVARCHAR (50)   NULL,
    CONSTRAINT [PK_ReceiptVoucher] PRIMARY KEY CLUSTERED ([RVId] ASC)
);

