CREATE TABLE [dbo].[ButcheryReturnDetail] (
    [Id]        INT             IDENTITY (1, 1) NOT NULL,
    [BUTRId]    INT             NULL,
    [ItemId]    INT             NULL,
    [Unit]      INT             NULL,
    [Rate]      DECIMAL (18, 2) NULL,
    [QTY]       DECIMAL (18, 2) NULL,
    [WesQty]    DECIMAL (18, 2) CONSTRAINT [DF_ButcheryReturnDetail_WesQty] DEFAULT ((0)) NULL,
    [Amount]    DECIMAL (18, 2) NULL,
    [RawItemId] INT             NULL,
    CONSTRAINT [FK_ButcheryReturnDetail_ButcheryReturnMaster] FOREIGN KEY ([BUTRId]) REFERENCES [dbo].[ButcheryReturnMaster] ([BUTRId])
);

