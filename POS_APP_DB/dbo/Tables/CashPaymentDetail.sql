CREATE TABLE [dbo].[CashPaymentDetail] (
    [id]        INT             IDENTITY (1, 1) NOT NULL,
    [Amount]    DECIMAL (18, 2) NULL,
    [CAId]      INT             NULL,
    [Desc]      NVARCHAR (MAX)  NULL,
    [CPId]      INT             NULL,
    [InvoiceId] INT             CONSTRAINT [DF_CashPaymentDetail_InvoiceId] DEFAULT ((0)) NULL,
    CONSTRAINT [CashPaymentMaster_CashPaymentDetail] FOREIGN KEY ([CPId]) REFERENCES [dbo].[CashPaymentMaster] ([CPId]) ON DELETE CASCADE,
    CONSTRAINT [FK_CashPaymentDetail_ChartOfAccount] FOREIGN KEY ([CAId]) REFERENCES [dbo].[ChartOfAccount] ([CAId]) ON DELETE CASCADE
);

