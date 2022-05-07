CREATE TABLE [dbo].[PhysicalStockMaster_Branch] (
    [PSBRId] INT            IDENTITY (1, 1) NOT NULL,
    [Date]   DATETIME       NULL,
    [PSNO]   NVARCHAR (50)  NULL,
    [BRId]   INT            NULL,
    [DId]    INT            CONSTRAINT [DF_PhysicalStockMaster_Branch_DId] DEFAULT ((0)) NULL,
    [Desc]   NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_PhysicalStockMaster_Branch] PRIMARY KEY CLUSTERED ([PSBRId] ASC),
    CONSTRAINT [FK_PhysicalStockMaster_Branch_Branch] FOREIGN KEY ([BRId]) REFERENCES [dbo].[Branch] ([BRId])
);

