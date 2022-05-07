CREATE TABLE [dbo].[Account_Register] (
    [id]          INT             IDENTITY (1, 1) NOT NULL,
    [Date]        DATETIME        NOT NULL,
    [Type]        NVARCHAR (1)    NOT NULL,
    [Debit]       DECIMAL (18, 2) CONSTRAINT [DF_Account_Register_Debit] DEFAULT ((0)) NULL,
    [Credit]      DECIMAL (18, 2) CONSTRAINT [DF_Account_Register_Credit] DEFAULT ((0)) NULL,
    [Description] NVARCHAR (MAX)  NOT NULL
);

