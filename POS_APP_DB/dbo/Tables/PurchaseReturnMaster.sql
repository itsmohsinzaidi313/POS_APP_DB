CREATE TABLE [dbo].[PurchaseReturnMaster] (
    [PRId]        INT             IDENTITY (1, 1) NOT NULL,
    [Date]        DATETIME        NULL,
    [UserId]      INT             NULL,
    [VId]         INT             NULL,
    [PRNo]        NVARCHAR (50)   NULL,
    [SId]         INT             NULL,
    [BRId]        INT             NULL,
    [Amount]      DECIMAL (18, 2) NULL,
    [Discount]    DECIMAL (18, 2) NULL,
    [TotalAmount] DECIMAL (18, 2) NULL,
    [InvoiceId]   INT             NULL,
    [RefNo]       NVARCHAR (50)   NULL,
    [TotalTax]    DECIMAL (18, 2) NULL,
    [COId]        INT             CONSTRAINT [DF_PurchaseReturnMaster_COId] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_PurchaseReturnMaster] PRIMARY KEY CLUSTERED ([PRId] ASC)
);

