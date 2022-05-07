CREATE TABLE [dbo].[item_stock_detail] (
    [id]        INT             IDENTITY (1, 1) NOT NULL,
    [master_id] INT             NOT NULL,
    [item_id]   INT             NULL,
    [last_rate] DECIMAL (18, 2) NULL,
    [balance]   DECIMAL (18, 2) NULL,
    [store_id]  INT             NULL,
    CONSTRAINT [PK_item_stock_detail] PRIMARY KEY CLUSTERED ([id] ASC)
);

