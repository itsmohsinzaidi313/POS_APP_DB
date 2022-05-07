CREATE TABLE [dbo].[TempDealsOnSpotItems] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [order_key]      NVARCHAR (50) NULL,
    [Order_detailId] INT           NULL,
    [deal_name]      NVARCHAR (50) NULL,
    [deal_price]     FLOAT (53)    NULL,
    [category_name]  NVARCHAR (50) NULL,
    [item_name]      NVARCHAR (50) NULL,
    [qty]            FLOAT (53)    NULL,
    [department]     NVARCHAR (50) NULL,
    [TiltId]         INT           NULL,
    [Status]         BIT           CONSTRAINT [DF_TempDealsOnSpotItems_Status] DEFAULT ((0)) NULL,
    [ItemQty]        FLOAT (53)    NULL
);

