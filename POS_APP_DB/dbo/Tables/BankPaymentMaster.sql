CREATE TABLE [dbo].[BankPaymentMaster] (
    [BPId]        INT             IDENTITY (1, 1) NOT NULL,
    [VN]          NVARCHAR (40)   NULL,
    [PVId]        INT             NULL,
    [Date]        DATETIME        NULL,
    [TotalAmount] DECIMAL (18, 2) NULL,
    [ChequeNo]    NVARCHAR (40)   NULL,
    [ChequeDate]  DATETIME        NULL,
    [CAId]        INT             NULL,
    [PaidTo]      NVARCHAR (MAX)  NULL,
    [For]         NVARCHAR (MAX)  NULL,
    [COId]        INT             NULL,
    [wht_caid]    INT             DEFAULT ((0)) NULL,
    [Tax]         DECIMAL (18, 2) DEFAULT ((0)) NULL,
    [TaxAmount]   DECIMAL (18, 2) DEFAULT ((0)) NULL,
    CONSTRAINT [PK_BankPaymentMaster] PRIMARY KEY CLUSTERED ([BPId] ASC),
    CONSTRAINT [FK_BankPaymentMaster_PaymentVoucher] FOREIGN KEY ([PVId]) REFERENCES [dbo].[PaymentVoucher] ([PVId]) ON DELETE CASCADE
);

