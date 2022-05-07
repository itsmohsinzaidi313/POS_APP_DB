CREATE TABLE [dbo].[TransferInMaster] (
    [TRIId]      INT IDENTITY (1, 1) NOT NULL,
    [TransferId] INT NULL,
    [TRInId]     INT NULL,
    CONSTRAINT [PK_TransferInMaster] PRIMARY KEY CLUSTERED ([TRIId] ASC),
    CONSTRAINT [FK_TransferInMaster_Transfer] FOREIGN KEY ([TransferId]) REFERENCES [dbo].[Transfer] ([TransferId])
);

