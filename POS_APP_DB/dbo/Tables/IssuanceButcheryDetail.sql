CREATE TABLE [dbo].[IssuanceButcheryDetail] (
    [Id]     INT             IDENTITY (1, 1) NOT NULL,
    [BUTId]  INT             NULL,
    [ItemId] INT             NULL,
    [Unit]   INT             NULL,
    [Rate]   DECIMAL (18, 2) NULL,
    [Qty]    DECIMAL (18, 2) NULL,
    [Amount] DECIMAL (18, 2) NULL,
    CONSTRAINT [FK_IssuanceButcheryDetail_IssuanceButcheryMaster] FOREIGN KEY ([BUTId]) REFERENCES [dbo].[IssuanceButcheryMaster] ([BUTId])
);

