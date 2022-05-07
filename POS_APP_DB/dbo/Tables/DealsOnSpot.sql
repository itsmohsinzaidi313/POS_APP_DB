CREATE TABLE [dbo].[DealsOnSpot] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [deal_name]     NVARCHAR (50) NULL,
    [deal_price]    FLOAT (53)    NULL,
    [category_name] NVARCHAR (50) NULL,
    [item_name]     NVARCHAR (50) NULL,
    [qty]           FLOAT (53)    NULL,
    [ChooseAny]     NVARCHAR (50) NULL,
    [department]    NVARCHAR (50) NULL,
    [TiltId]        INT           NULL,
    [ItemQty]       FLOAT (53)    NULL,
    [orderid]       INT           DEFAULT ((0)) NOT NULL,
    [GetType]       NVARCHAR (50) NULL,
    [Is_upload]     BIT           DEFAULT ((0)) NOT NULL,
    [Is_update]     BIT           DEFAULT ((0)) NOT NULL
);

