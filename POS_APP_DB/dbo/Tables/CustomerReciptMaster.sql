CREATE TABLE [dbo].[CustomerReciptMaster] (
    [CustRId]      INT             IDENTITY (1, 1) NOT NULL,
    [PaymentNo]    NVARCHAR (50)   NULL,
    [Date]         DATETIME        NULL,
    [CustId]       INT             NULL,
    [Amount]       DECIMAL (18, 2) NULL,
    [PaymentMode]  NVARCHAR (50)   NULL,
    [ChequeNo]     NVARCHAR (50)   NULL,
    [ChequeDate]   DATETIME        NULL,
    [CreditCardNo] NVARCHAR (50)   NULL,
    [status]       BIT             DEFAULT ((0)) NULL,
    [is_upload]    BIT             DEFAULT ((0)) NOT NULL,
    [is_update]    BIT             DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_CustomerReciptMaster] PRIMARY KEY CLUSTERED ([CustRId] ASC)
);

