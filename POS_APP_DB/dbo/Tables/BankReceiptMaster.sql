CREATE TABLE [dbo].[BankReceiptMaster] (
    [BRId]        INT             IDENTITY (1, 1) NOT NULL,
    [VN]          NVARCHAR (40)   NULL,
    [RVId]        INT             NULL,
    [Date]        DATETIME        NULL,
    [TotalAmount] DECIMAL (18, 2) NULL,
    [ChequeNo]    NVARCHAR (40)   NULL,
    [ChequeDate]  DATETIME        NULL,
    [CAId]        INT             NULL,
    [ReceiveFrom] NVARCHAR (MAX)  NULL,
    [For]         NVARCHAR (40)   NULL,
    [COId]        INT             NULL,
    CONSTRAINT [PK_BankReceiptMaster] PRIMARY KEY CLUSTERED ([BRId] ASC)
);

