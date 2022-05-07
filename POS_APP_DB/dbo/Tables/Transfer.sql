CREATE TABLE [dbo].[Transfer] (
    [TransferId]  INT             IDENTITY (1, 1) NOT NULL,
    [Date]        DATETIME        NULL,
    [TRNo]        NVARCHAR (50)   NULL,
    [UserId]      INT             NULL,
    [TotalAmount] DECIMAL (18, 2) NULL,
    [From]        NVARCHAR (50)   NULL,
    [To]          NVARCHAR (50)   NULL,
    CONSTRAINT [PK_Transfer] PRIMARY KEY CLUSTERED ([TransferId] ASC)
);

