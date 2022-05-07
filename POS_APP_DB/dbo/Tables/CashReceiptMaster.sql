CREATE TABLE [dbo].[CashReceiptMaster] (
    [CRId]        INT            IDENTITY (1, 1) NOT NULL,
    [VN]          NVARCHAR (40)  NULL,
    [RVId]        INT            NULL,
    [Date]        DATETIME       NULL,
    [TotalAmount] DECIMAL (18)   NULL,
    [ReceiveFrom] NVARCHAR (MAX) NULL,
    [For]         NVARCHAR (40)  NULL,
    [CAId]        INT            NULL,
    [COId]        INT            NULL,
    CONSTRAINT [PK_CashReceiptMaster] PRIMARY KEY CLUSTERED ([CRId] ASC)
);

