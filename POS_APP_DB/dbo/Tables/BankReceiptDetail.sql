CREATE TABLE [dbo].[BankReceiptDetail] (
    [id]     INT             IDENTITY (1, 1) NOT NULL,
    [Amount] DECIMAL (18, 2) NULL,
    [CAId]   INT             NULL,
    [Desc]   NVARCHAR (MAX)  NULL,
    [BRId]   INT             NULL,
    [SaleId] INT             CONSTRAINT [DF_BankReceiptDetail_SaleId] DEFAULT ((0)) NULL,
    CONSTRAINT [BankReceiptMaster_BankReceiptDetail] FOREIGN KEY ([BRId]) REFERENCES [dbo].[BankReceiptMaster] ([BRId]),
    CONSTRAINT [FK_BankReceiptDetail_ChartOfAccount] FOREIGN KEY ([CAId]) REFERENCES [dbo].[ChartOfAccount] ([CAId]) ON DELETE CASCADE
);

