CREATE TABLE [dbo].[ItemUnit] (
    [id]         INT             IDENTITY (1, 1) NOT NULL,
    [ItemId]     INT             NULL,
    [PkUnit]     INT             NULL,
    [PkFactor]   DECIMAL (18, 2) NULL,
    [PurUnit]    INT             NULL,
    [PurFactor]  DECIMAL (18, 2) NULL,
    [IssUnit]    INT             NULL,
    [IssFactor]  DECIMAL (18, 2) NULL,
    [RecpUnit]   INT             NULL,
    [RecpFactor] DECIMAL (18, 2) NULL,
    CONSTRAINT [FK_ItemUnit_Item] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Item] ([ItemId])
);

