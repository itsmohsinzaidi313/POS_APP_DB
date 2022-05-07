CREATE TABLE [dbo].[PhysicalStockMaster_Store] (
    [PSId] INT            IDENTITY (1, 1) NOT NULL,
    [Date] DATETIME       NULL,
    [PSNO] NVARCHAR (50)  NULL,
    [SId]  INT            NULL,
    [Desc] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_PhysicalStockMaster_Store] PRIMARY KEY CLUSTERED ([PSId] ASC),
    CONSTRAINT [FK_PhysicalStockMaster_Store_Store] FOREIGN KEY ([SId]) REFERENCES [dbo].[Store] ([SId])
);

