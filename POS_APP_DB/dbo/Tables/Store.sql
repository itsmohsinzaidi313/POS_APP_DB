CREATE TABLE [dbo].[Store] (
    [SId]          INT           IDENTITY (1, 1) NOT NULL,
    [Store]        NVARCHAR (50) NULL,
    [CentarlStore] BIT           CONSTRAINT [DF_Store_CentarlStore] DEFAULT ((1)) NULL,
    [COId]         INT           NULL,
    [IsSelected]   BIT           CONSTRAINT [DF_Store_IsSelected] DEFAULT ((1)) NULL,
    [BrId]         INT           DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED ([SId] ASC),
    CONSTRAINT [FK_Store_Company] FOREIGN KEY ([COId]) REFERENCES [dbo].[Company] ([COId])
);

