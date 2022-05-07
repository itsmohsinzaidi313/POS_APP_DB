CREATE TABLE [dbo].[TableMerge] (
    [id]           INT           IDENTITY (1, 1) NOT NULL,
    [OrderkeyFrom] NVARCHAR (50) NULL,
    [OrderKeyTo]   NVARCHAR (50) NULL,
    [OrderNoFrom]  INT           NULL,
    [OrderNoTo]    INT           NULL,
    [Z_Number]     NVARCHAR (50) NULL,
    [TableNoFrom]  NVARCHAR (50) NULL,
    [TableNoTo]    NVARCHAR (50) NULL,
    [AmountFrom]   FLOAT (53)    NULL,
    [AmountTo]     FLOAT (53)    NULL,
    [OrderDate]    DATETIME      NULL,
    [ServerFrom]   NVARCHAR (50) NULL,
    [ServerTo]     NVARCHAR (50) NULL,
    [CoverFrom]    INT           NULL,
    [CoverTo]      INT           NULL
);

