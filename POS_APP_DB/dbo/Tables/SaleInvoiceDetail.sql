CREATE TABLE [dbo].[SaleInvoiceDetail] (
    [id]            INT             IDENTITY (1, 1) NOT NULL,
    [Desc]          NVARCHAR (MAX)  NULL,
    [Amount]        DECIMAL (18, 2) NULL,
    [SaleInvoiceId] INT             NULL,
    [CAId]          INT             NULL
);

