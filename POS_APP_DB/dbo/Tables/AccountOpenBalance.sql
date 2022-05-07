CREATE TABLE [dbo].[AccountOpenBalance] (
    [id]     INT             IDENTITY (1, 1) NOT NULL,
    [Amount] DECIMAL (18, 2) NULL,
    [CAId]   INT             NULL,
    [APId]   INT             NULL,
    CONSTRAINT [ChartOfAccount_AccountOpenBalance] FOREIGN KEY ([CAId]) REFERENCES [dbo].[ChartOfAccount] ([CAId]) ON DELETE CASCADE
);

