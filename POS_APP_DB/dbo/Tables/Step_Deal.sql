CREATE TABLE [dbo].[Step_Deal] (
    [id]           INT             IDENTITY (1, 1) NOT NULL,
    [Deal_Id]      INT             NOT NULL,
    [Dealname]     NVARCHAR (50)   NOT NULL,
    [Steps]        INT             NOT NULL,
    [PriceOnstep]  INT             NOT NULL,
    [Step_id]      INT             NOT NULL,
    [Step]         NCHAR (10)      NOT NULL,
    [Category_id]  INT             NOT NULL,
    [Item_Id]      INT             NOT NULL,
    [Item_Qty]     DECIMAL (18, 2) NOT NULL,
    [Is_PriceItem] BIT             CONSTRAINT [DF_Step_Deal_Is_PriceItem] DEFAULT ((0)) NOT NULL,
    [Item_Price]   DECIMAL (18, 2) CONSTRAINT [DF_Step_Deal_Item_Price] DEFAULT ((0)) NOT NULL,
    [DealPrice]    DECIMAL (18, 2) DEFAULT ((0)) NOT NULL
);

