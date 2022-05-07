CREATE TABLE [dbo].[InvAdjDetail_Store] (
    [id]     INT             IDENTITY (1, 1) NOT NULL,
    [AdjId]  INT             NULL,
    [ItemId] INT             NULL,
    [Unit]   INT             NULL,
    [Qty]    DECIMAL (18, 2) NULL,
    [Rate]   DECIMAL (18, 2) NULL,
    [Type]   NVARCHAR (50)   NULL,
    CONSTRAINT [FK_InvAdjDetail_Store_Item] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Item] ([ItemId])
);

