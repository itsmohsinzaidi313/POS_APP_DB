CREATE TABLE [dbo].[DiscountSetting] (
    [id]               INT             IDENTITY (1, 1) NOT NULL,
    [CareOf]           NVARCHAR (100)  NULL,
    [Percentage]       DECIMAL (18, 2) NULL,
    [IsPercent]        BIT             CONSTRAINT [DF_DiscountSetting_IsPercent] DEFAULT ((0)) NULL,
    [from]             NVARCHAR (50)   NULL,
    [To]               NVARCHAR (50)   NULL,
    [OrderType]        NVARCHAR (50)   NULL,
    [Is_HappyHour]     BIT             DEFAULT ((0)) NOT NULL,
    [IsActive]         BIT             DEFAULT ((0)) NOT NULL,
    [AutoDiscount]     BIT             DEFAULT ((0)) NOT NULL,
    [credit_card_info] NVARCHAR (MAX)  NULL,
    [IsBank]           BIT             DEFAULT ((0)) NULL,
    [cashback]         FLOAT (53)      NULL,
    [limit]            INT             NULL,
    [IsLimit]          INT             NULL
);

