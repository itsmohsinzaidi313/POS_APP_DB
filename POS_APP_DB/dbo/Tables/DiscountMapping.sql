CREATE TABLE [dbo].[DiscountMapping] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [CAId]        INT           NULL,
    [Type]        NVARCHAR (50) NULL,
    [Transaction] NVARCHAR (50) NULL,
    [Form]        NVARCHAR (50) NULL
);

