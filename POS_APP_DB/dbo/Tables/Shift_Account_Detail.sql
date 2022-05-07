CREATE TABLE [dbo].[Shift_Account_Detail] (
    [ID]           INT             IDENTITY (1, 1) NOT NULL,
    [z_number]     NVARCHAR (50)   NULL,
    [payment_type] NVARCHAR (50)   NULL,
    [Amount]       DECIMAL (18, 2) NULL,
    CONSTRAINT [PK_Shift_Account_Detail] PRIMARY KEY CLUSTERED ([ID] ASC)
);

