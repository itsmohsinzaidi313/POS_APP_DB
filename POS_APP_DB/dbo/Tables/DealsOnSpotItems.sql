CREATE TABLE [dbo].[DealsOnSpotItems] (
    [id]              INT             IDENTITY (1, 1) NOT NULL,
    [order_key]       NVARCHAR (50)   NULL,
    [Order_detailId]  INT             NULL,
    [deal_name]       NVARCHAR (50)   NULL,
    [deal_price]      FLOAT (53)      NULL,
    [category_name]   NVARCHAR (50)   NULL,
    [item_name]       NVARCHAR (50)   NULL,
    [qty]             FLOAT (53)      NULL,
    [department]      NVARCHAR (50)   NULL,
    [TiltId]          INT             NULL,
    [Status]          BIT             CONSTRAINT [DF_DealsOnSpotItems_Status] DEFAULT ((0)) NULL,
    [ItemQty]         FLOAT (53)      NULL,
    [OrderKey_Merege] NVARCHAR (50)   NULL,
    [Price_Item]      DECIMAL (18, 2) DEFAULT ((0)) NOT NULL,
    [item_comment]    NVARCHAR (50)   NULL
);

