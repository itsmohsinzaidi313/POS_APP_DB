CREATE TABLE [dbo].[POS_Expense_Account] (
    [id]      INT           IDENTITY (1, 1) NOT NULL,
    [Account] NVARCHAR (50) NOT NULL,
    [CAId]    INT           NOT NULL
);

