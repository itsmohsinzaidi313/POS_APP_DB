CREATE TABLE [dbo].[MenuDetail] (
    [id]       INT           IDENTITY (1, 1) NOT NULL,
    [ItemId]   INT           NULL,
    [MenuItem] NVARCHAR (50) NULL,
    [Qty]      FLOAT (53)    NULL
);

