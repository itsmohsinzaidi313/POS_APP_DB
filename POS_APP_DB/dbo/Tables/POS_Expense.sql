CREATE TABLE [dbo].[POS_Expense] (
    [id]          INT             IDENTITY (1, 1) NOT NULL,
    [Type]        NCHAR (10)      NOT NULL,
    [Vn]          NVARCHAR (50)   NOT NULL,
    [VoucherId]   INT             CONSTRAINT [DF_POS_Expense_VoucherId] DEFAULT ((0)) NULL,
    [date]        DATETIME        NOT NULL,
    [Amount]      DECIMAL (18, 2) NOT NULL,
    [CAId]        INT             NOT NULL,
    [Vouchertype] NVARCHAR (50)   NOT NULL,
    [Desc]        NVARCHAR (MAX)  NULL
);

