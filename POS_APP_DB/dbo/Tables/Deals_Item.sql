CREATE TABLE [dbo].[Deals_Item] (
    [id]              INT             IDENTITY (1, 1) NOT NULL,
    [Order_Key]       NVARCHAR (50)   NOT NULL,
    [Order_Detail_id] INT             NOT NULL,
    [Deal_name]       NVARCHAR (50)   NOT NULL,
    [deal_Price]      DECIMAL (18, 2) NOT NULL,
    [Deal_Qty]        DECIMAL (18, 2) NOT NULL,
    [Department]      NVARCHAR (50)   NOT NULL,
    [Category_name]   NVARCHAR (50)   NOT NULL,
    [Item_name]       NVARCHAR (50)   NOT NULL,
    [Item_Qty]        DECIMAL (18, 2) NOT NULL,
    [Item_Price]      DECIMAL (18, 2) NOT NULL,
    [item_comment]    NVARCHAR (50)   NULL
);

