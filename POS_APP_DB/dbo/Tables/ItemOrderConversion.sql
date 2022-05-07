CREATE TABLE [dbo].[ItemOrderConversion] (
    [id]         INT             IDENTITY (1, 1) NOT NULL,
    [ItemId]     INT             NULL,
    [OrderQty]   DECIMAL (18, 2) NULL,
    [IssUnitId]  INT             NULL,
    [Conversion] DECIMAL (18, 2) NULL,
    CONSTRAINT [FK_ItemOrderConversion_Item] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Item] ([ItemId])
);

