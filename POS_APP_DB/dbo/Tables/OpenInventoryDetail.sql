CREATE TABLE [dbo].[OpenInventoryDetail] (
    [id]        INT             IDENTITY (1, 1) NOT NULL,
    [OpenInvId] INT             NULL,
    [ItemId]    INT             NULL,
    [Qty]       DECIMAL (18, 2) NULL,
    [Rate]      DECIMAL (18, 2) NULL,
    [Amount]    DECIMAL (18, 2) NULL,
    [Unit]      INT             CONSTRAINT [DF_OpenInventoryDetail_Unit] DEFAULT ((0)) NULL,
    CONSTRAINT [FK_OpenInventoryDetail_Item] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Item] ([ItemId]),
    CONSTRAINT [FK_OpenInventoryDetail_OpenInventoryMaster] FOREIGN KEY ([OpenInvId]) REFERENCES [dbo].[OpenInventoryMaster] ([OpenInvId])
);

