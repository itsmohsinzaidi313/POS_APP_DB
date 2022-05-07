CREATE TABLE [dbo].[TransferOutMaster] (
    [TRId]       INT IDENTITY (1, 1) NOT NULL,
    [TransferId] INT NULL,
    [TROutId]    INT NULL,
    CONSTRAINT [PK_TransferMaster] PRIMARY KEY CLUSTERED ([TRId] ASC),
    CONSTRAINT [FK_TransferOutMaster_Transfer] FOREIGN KEY ([TransferId]) REFERENCES [dbo].[Transfer] ([TransferId])
);

