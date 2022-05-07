CREATE TABLE [dbo].[OrderMaster] (
    [Id]                   INT           IDENTITY (1, 1) NOT NULL,
    [OrderDate]            DATETIME      NULL,
    [Time]                 NVARCHAR (50) NULL,
    [CustomerId]           INT           NULL,
    [OrderNo]              NVARCHAR (50) NULL,
    [isDelete]             BIT           CONSTRAINT [DF_OrderMaster_isDelete] DEFAULT ((0)) NULL,
    [TotalAmount]          FLOAT (53)    NULL,
    [Discount]             FLOAT (53)    NULL,
    [AmountBeforeDiscount] FLOAT (53)    NULL,
    [Status]               NVARCHAR (50) NULL,
    [VAT]                  FLOAT (53)    NULL,
    [CLevy]                FLOAT (53)    NULL,
    [TaxType]              NVARCHAR (50) NULL
);

