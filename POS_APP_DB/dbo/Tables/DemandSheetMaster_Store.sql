CREATE TABLE [dbo].[DemandSheetMaster_Store] (
    [DSCOId] INT            IDENTITY (0, 1) NOT NULL,
    [SId]    INT            NULL,
    [Date]   DATETIME       NULL,
    [DSNo]   VARCHAR (50)   NULL,
    [COId]   INT            NULL,
    [Desc]   NVARCHAR (MAX) NULL,
    [Vid]    INT            DEFAULT ((0)) NULL,
    CONSTRAINT [PK__DemandSheetMaste__222B06A9] PRIMARY KEY CLUSTERED ([DSCOId] ASC),
    CONSTRAINT [FK_DemandSheetMaster_Store_Company] FOREIGN KEY ([COId]) REFERENCES [dbo].[Company] ([COId]),
    CONSTRAINT [FK_DemandSheetMaster_Store_Store] FOREIGN KEY ([SId]) REFERENCES [dbo].[Store] ([SId])
);

