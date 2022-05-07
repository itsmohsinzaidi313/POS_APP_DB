CREATE TABLE [dbo].[SheeshaTime] (
    [id]           INT             IDENTITY (1, 1) NOT NULL,
    [time]         NVARCHAR (50)   NULL,
    [cashDrop]     DECIMAL (18, 2) DEFAULT ((0)) NOT NULL,
    [CashDropTime] INT             DEFAULT ((0)) NOT NULL
);

