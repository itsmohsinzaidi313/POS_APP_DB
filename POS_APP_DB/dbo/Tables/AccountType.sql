CREATE TABLE [dbo].[AccountType] (
    [id]   INT          IDENTITY (1, 1) NOT NULL,
    [Type] VARCHAR (40) NULL,
    CONSTRAINT [PK_AccountType] PRIMARY KEY CLUSTERED ([id] ASC)
);

