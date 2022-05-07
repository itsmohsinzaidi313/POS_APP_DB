CREATE TABLE [dbo].[Counter_Opening_Expense_Log] (
    [id]        INT             IDENTITY (1, 1) NOT NULL,
    [User]      NVARCHAR (MAX)  NOT NULL,
    [CounterId] INT             NOT NULL,
    [date]      DATETIME        NOT NULL,
    [Time]      NVARCHAR (50)   NOT NULL,
    [Balance]   DECIMAL (18, 2) NOT NULL
);

