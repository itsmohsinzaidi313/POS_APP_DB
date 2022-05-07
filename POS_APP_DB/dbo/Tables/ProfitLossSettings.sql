CREATE TABLE [dbo].[ProfitLossSettings] (
    [id]        INT           IDENTITY (1, 1) NOT NULL,
    [Section]   NVARCHAR (50) NULL,
    [AccNoFrom] INT           NULL,
    [AccNoTo]   INT           NULL,
    [Title]     NVARCHAR (50) NULL
);

