CREATE TABLE [dbo].[currency_convertor] (
    [id]       INT             IDENTITY (1, 1) NOT NULL,
    [currency] NVARCHAR (50)   NULL,
    [rate]     DECIMAL (18, 2) NULL
);

