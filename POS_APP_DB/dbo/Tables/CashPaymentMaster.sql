CREATE TABLE [dbo].[CashPaymentMaster] (
    [CPId]        INT             IDENTITY (1, 1) NOT NULL,
    [VN]          NVARCHAR (40)   NULL,
    [PVId]        INT             NULL,
    [Date]        DATETIME        NULL,
    [TotalAmount] DECIMAL (18, 2) NULL,
    [PaidTo]      NVARCHAR (40)   NULL,
    [For]         NVARCHAR (40)   NULL,
    [CAId]        INT             NULL,
    [COId]        INT             NULL,
    [wht_caid]    INT             DEFAULT ((0)) NULL,
    [Tax]         DECIMAL (18, 2) DEFAULT ((0)) NULL,
    [TaxAmount]   DECIMAL (18, 2) DEFAULT ((0)) NULL,
    CONSTRAINT [PK_CashPaymentMaster] PRIMARY KEY CLUSTERED ([CPId] ASC),
    CONSTRAINT [FK_CashPaymentMaster_PaymentVoucher] FOREIGN KEY ([PVId]) REFERENCES [dbo].[PaymentVoucher] ([PVId]) ON DELETE CASCADE
);

