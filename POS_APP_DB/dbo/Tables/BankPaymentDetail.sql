CREATE TABLE [dbo].[BankPaymentDetail] (
    [id]        INT             IDENTITY (1, 1) NOT NULL,
    [Amount]    DECIMAL (18, 2) NULL,
    [CAId]      INT             NULL,
    [Desc]      NVARCHAR (MAX)  NULL,
    [BPId]      INT             NULL,
    [InvoiceId] INT             CONSTRAINT [DF_BankPaymentDetail_InvoiceId] DEFAULT ((0)) NULL,
    CONSTRAINT [BankPaymentMaster_BankPaymentDetail] FOREIGN KEY ([BPId]) REFERENCES [dbo].[BankPaymentMaster] ([BPId]) ON DELETE CASCADE,
    CONSTRAINT [FK_BankPaymentDetail_ChartOfAccount] FOREIGN KEY ([CAId]) REFERENCES [dbo].[ChartOfAccount] ([CAId]) ON DELETE CASCADE
);

