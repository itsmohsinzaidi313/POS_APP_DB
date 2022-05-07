CREATE TABLE [dbo].[TransferOutDetail] (
    [Id]        INT             IDENTITY (1, 1) NOT NULL,
    [TRId]      INT             NULL,
    [ItemId]    INT             NULL,
    [Unit]      INT             CONSTRAINT [DF_TransferOutDetail_Unit] DEFAULT ((0)) NULL,
    [Qty]       DECIMAL (18, 2) NULL,
    [Rate]      DECIMAL (18, 2) NULL,
    [PackageId] INT             CONSTRAINT [DF_TransferOutDetail_PackageId] DEFAULT ((0)) NULL,
    CONSTRAINT [FK_TransferOutDetail_TransferOutMaster] FOREIGN KEY ([TRId]) REFERENCES [dbo].[TransferOutMaster] ([TRId])
);

