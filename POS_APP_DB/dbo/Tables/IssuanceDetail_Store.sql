CREATE TABLE [dbo].[IssuanceDetail_Store] (
    [id]      INT             IDENTITY (1, 1) NOT NULL,
    [IssId]   INT             NULL,
    [ItemId]  INT             NULL,
    [Unit]    INT             NULL,
    [Rate]    DECIMAL (18, 2) NULL,
    [Qty]     DECIMAL (18, 2) NULL,
    [Amount]  DECIMAL (18, 2) NULL,
    [DSId]    INT             CONSTRAINT [DF_IssuanceDetail_Store_DSId] DEFAULT ((0)) NULL,
    [Qty_Pcs] DECIMAL (18, 2) DEFAULT ((0)) NULL,
    CONSTRAINT [FK_IssuanceDetail_Store_IssuanceMaster_Store] FOREIGN KEY ([IssId]) REFERENCES [dbo].[IssuanceMaster_Store] ([IssId])
);

