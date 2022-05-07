CREATE TABLE [dbo].[ItemRate] (
    [id]     INT             IDENTITY (1, 1) NOT NULL,
    [Date]   DATETIME        NULL,
    [ItemId] INT             NULL,
    [Rate]   DECIMAL (18, 2) NULL
);

