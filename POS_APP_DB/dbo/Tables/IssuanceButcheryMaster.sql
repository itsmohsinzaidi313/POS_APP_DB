CREATE TABLE [dbo].[IssuanceButcheryMaster] (
    [BUTId]  INT           IDENTITY (1, 1) NOT NULL,
    [Date]   DATETIME      NULL,
    [SId]    INT           NULL,
    [UserId] INT           NULL,
    [BRId]   INT           NULL,
    [ISSBNo] NVARCHAR (50) NULL,
    CONSTRAINT [PK_IssuanceButcheryMaster] PRIMARY KEY CLUSTERED ([BUTId] ASC)
);

