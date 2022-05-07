CREATE TABLE [dbo].[PaymentVoucher] (
    [PVId]        INT             IDENTITY (1, 1) NOT NULL,
    [Date]        DATETIME        NULL,
    [SPId]        INT             CONSTRAINT [DEF_PaymentVoucher_SPId] DEFAULT ((0)) NULL,
    [Amount]      DECIMAL (18, 2) NULL,
    [PaymentMode] VARCHAR (40)    NULL,
    [COId]        INT             NULL,
    [Type]        NVARCHAR (50)   NULL,
    CONSTRAINT [PK_PaymentVoucher] PRIMARY KEY CLUSTERED ([PVId] ASC)
);

