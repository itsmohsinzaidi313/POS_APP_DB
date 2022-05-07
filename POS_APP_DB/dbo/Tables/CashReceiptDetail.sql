CREATE TABLE [dbo].[CashReceiptDetail] (
    [id]     INT            IDENTITY (1, 1) NOT NULL,
    [Amount] DECIMAL (18)   NULL,
    [CAId]   INT            NULL,
    [Desc]   NVARCHAR (MAX) NULL,
    [CRId]   INT            NULL,
    [SaleId] INT            CONSTRAINT [DF_CashReceiptDetail_SaleId] DEFAULT ((0)) NULL,
    CONSTRAINT [CashReceiptMaster_CashReceiptDetail] FOREIGN KEY ([CRId]) REFERENCES [dbo].[CashReceiptMaster] ([CRId]),
    CONSTRAINT [FK_CashReceiptDetail_ChartOfAccount] FOREIGN KEY ([CAId]) REFERENCES [dbo].[ChartOfAccount] ([CAId]) ON DELETE CASCADE
);

