CREATE TABLE [dbo].[IssuanceReturnMaster] (
    [IssRTId] INT           IDENTITY (1, 1) NOT NULL,
    [Date]    DATETIME      NULL,
    [SId]     INT           NULL,
    [BRId]    INT           NULL,
    [UserId]  INT           NULL,
    [IssRNo]  NVARCHAR (50) NULL,
    [DSId]    INT           NULL,
    [DId]     INT           CONSTRAINT [DF_IssuanceReturnMaster_DId] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_IssuanceReturnMaster] PRIMARY KEY CLUSTERED ([IssRTId] ASC)
);

