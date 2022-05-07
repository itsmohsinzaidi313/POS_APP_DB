CREATE TABLE [dbo].[Tax_] (
    [Id]              INT             IDENTITY (1, 1) NOT NULL,
    [IsApplicable]    BIT             NULL,
    [TaxType]         NVARCHAR (50)   NULL,
    [Tax]             DECIMAL (18, 2) NULL,
    [Type]            NVARCHAR (50)   NULL,
    [CAId]            INT             CONSTRAINT [DF_Tax__CAId] DEFAULT ((0)) NULL,
    [TransactionType] NVARCHAR (50)   NULL
);

