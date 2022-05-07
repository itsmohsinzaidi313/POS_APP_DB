CREATE TABLE [dbo].[Item] (
    [ItemId]   INT             IDENTITY (1, 1) NOT NULL,
    [SBId]     INT             NULL,
    [Item]     NVARCHAR (50)   NULL,
    [GRId]     INT             CONSTRAINT [DF_Item_GRId] DEFAULT ((0)) NULL,
    [ItemCode] NVARCHAR (50)   NULL,
    [Type]     NVARCHAR (50)   NULL,
    [Yield]    DECIMAL (18, 2) DEFAULT ((0)) NOT NULL,
    [Vid]      INT             DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED ([ItemId] ASC),
    CONSTRAINT [FK_Item_SubCategory] FOREIGN KEY ([SBId]) REFERENCES [dbo].[SubCategory] ([SBId])
);

