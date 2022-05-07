CREATE TABLE [dbo].[ProductionMaster] (
    [PRId]   INT           IDENTITY (1, 1) NOT NULL,
    [Date]   DATETIME      NULL,
    [PRNo]   NVARCHAR (50) NULL,
    [Sid]    INT           NULL,
    [Amount] INT           NULL,
    CONSTRAINT [PK_ProductionMaster] PRIMARY KEY CLUSTERED ([PRId] ASC)
);

