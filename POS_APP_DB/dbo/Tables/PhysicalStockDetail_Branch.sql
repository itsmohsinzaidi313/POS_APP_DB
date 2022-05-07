CREATE TABLE [dbo].[PhysicalStockDetail_Branch] (
    [id]     INT             IDENTITY (1, 1) NOT NULL,
    [PSBRId] INT             NULL,
    [ItemId] INT             NULL,
    [UnitId] INT             NULL,
    [Qty]    DECIMAL (18, 2) NULL,
    [Amount] DECIMAL (18, 2) NULL,
    CONSTRAINT [FK_PhysicalStockDetail_Branch_Item] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Item] ([ItemId]),
    CONSTRAINT [FK_PhysicalStockDetail_Branch_PhysicalStockMaster_Branch] FOREIGN KEY ([PSBRId]) REFERENCES [dbo].[PhysicalStockMaster_Branch] ([PSBRId])
);

