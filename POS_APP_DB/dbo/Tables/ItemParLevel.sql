CREATE TABLE [dbo].[ItemParLevel] (
    [id]       INT             IDENTITY (1, 1) NOT NULL,
    [ItemId]   INT             NULL,
    [BRId]     INT             NULL,
    [ParLevel] DECIMAL (18, 2) NULL,
    [SId]      INT             CONSTRAINT [DF_ItemParLevel_SId] DEFAULT ((0)) NULL,
    [DId]      INT             CONSTRAINT [DF_ItemParLevel_DId] DEFAULT ((0)) NULL,
    CONSTRAINT [FK_ItemParLevel_Item] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Item] ([ItemId])
);

