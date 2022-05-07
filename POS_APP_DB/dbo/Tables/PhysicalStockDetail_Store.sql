CREATE TABLE [dbo].[PhysicalStockDetail_Store] (
    [id]     INT             IDENTITY (1, 1) NOT NULL,
    [PSId]   INT             NULL,
    [ItemId] INT             NULL,
    [UId]    INT             NULL,
    [Qty]    DECIMAL (18, 2) NULL,
    [Amount] DECIMAL (18, 2) NULL,
    CONSTRAINT [FK_PhysicalStockDetail_Store_Item] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Item] ([ItemId]),
    CONSTRAINT [FK_PhysicalStockDetail_Store_PhysicalStockMaster_Store] FOREIGN KEY ([PSId]) REFERENCES [dbo].[PhysicalStockMaster_Store] ([PSId])
);

