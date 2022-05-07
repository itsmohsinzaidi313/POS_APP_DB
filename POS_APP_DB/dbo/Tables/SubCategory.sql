CREATE TABLE [dbo].[SubCategory] (
    [SBId]        INT           IDENTITY (1, 1) NOT NULL,
    [CId]         INT           NULL,
    [SubCategory] NVARCHAR (50) NULL,
    CONSTRAINT [PK_SubCategory] PRIMARY KEY CLUSTERED ([SBId] ASC),
    CONSTRAINT [FK_SubCategory_Category1] FOREIGN KEY ([CId]) REFERENCES [dbo].[Category] ([CId])
);

