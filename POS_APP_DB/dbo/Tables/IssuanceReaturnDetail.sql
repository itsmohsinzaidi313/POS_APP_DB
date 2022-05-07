CREATE TABLE [dbo].[IssuanceReaturnDetail] (
    [Id]      INT             IDENTITY (1, 1) NOT NULL,
    [IssRTId] INT             NULL,
    [ItemId]  INT             NULL,
    [Unit]    INT             NULL,
    [Rate]    DECIMAL (18, 2) NULL,
    [QTY]     DECIMAL (18, 2) NULL,
    [Amount]  DECIMAL (18, 2) NULL,
    CONSTRAINT [FK_IssuanceReaturnDetail_IssuanceReturnMaster] FOREIGN KEY ([IssRTId]) REFERENCES [dbo].[IssuanceReturnMaster] ([IssRTId])
);

