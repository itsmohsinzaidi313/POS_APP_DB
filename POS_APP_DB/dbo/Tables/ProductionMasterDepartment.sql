CREATE TABLE [dbo].[ProductionMasterDepartment] (
    [PRId]   INT           IDENTITY (1, 1) NOT NULL,
    [Date]   DATETIME      NULL,
    [PRNo]   NVARCHAR (50) NULL,
    [Sid]    INT           NULL,
    [Amount] INT           NULL,
    [BRId]   INT           NULL,
    [Did]    INT           NULL,
    CONSTRAINT [PK_ProductionMasterDepartment] PRIMARY KEY CLUSTERED ([PRId] ASC)
);

