CREATE TABLE [dbo].[ButcheryReturnMaster] (
    [BUTRId] INT           IDENTITY (1, 1) NOT NULL,
    [Date]   DATETIME      NULL,
    [SId]    INT           NULL,
    [BUTId]  INT           NULL,
    [UserId] INT           NULL,
    [BURNo]  NVARCHAR (50) NULL,
    CONSTRAINT [PK_ButcheryReturnMaster] PRIMARY KEY CLUSTERED ([BUTRId] ASC)
);

