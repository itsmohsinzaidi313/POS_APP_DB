CREATE TABLE [dbo].[ProductSaleMaster] (
    [PMID]      INT           IDENTITY (1, 1) NOT NULL,
    [ProductId] INT           NULL,
    [ZNumber]   NVARCHAR (50) NULL,
    [Date]      DATETIME      NULL
);

