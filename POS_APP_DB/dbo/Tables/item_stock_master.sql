CREATE TABLE [dbo].[item_stock_master] (
    [id]   INT      IDENTITY (1, 1) NOT NULL,
    [date] DATETIME NULL,
    CONSTRAINT [PK_item_stock_master] PRIMARY KEY CLUSTERED ([id] ASC)
);

