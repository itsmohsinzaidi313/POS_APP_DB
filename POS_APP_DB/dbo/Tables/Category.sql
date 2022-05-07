CREATE TABLE [dbo].[Category] (
    [CId]      INT           IDENTITY (1, 1) NOT NULL,
    [Category] NVARCHAR (50) NULL,
    [COID]     INT           NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([CId] ASC),
    CONSTRAINT [FK_Category_Company] FOREIGN KEY ([COID]) REFERENCES [dbo].[Company] ([COId])
);

