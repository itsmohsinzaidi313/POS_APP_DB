CREATE TABLE [dbo].[TransferInDetail] (
    [Id]        INT             IDENTITY (1, 1) NOT NULL,
    [TRIId]     INT             NULL,
    [ItemId]    INT             NULL,
    [Unit]      INT             NULL,
    [Qty]       DECIMAL (18, 2) NULL,
    [Rate]      DECIMAL (18, 2) NULL,
    [PackageId] INT             CONSTRAINT [DF_TransferInDetail_PackageId] DEFAULT ((0)) NULL,
    CONSTRAINT [FK_TransferInDetail_TransferInMaster] FOREIGN KEY ([TRIId]) REFERENCES [dbo].[TransferInMaster] ([TRIId])
);

