CREATE TABLE [dbo].[Voucher] (
    [id]          INT             IDENTITY (1, 1) NOT NULL,
    [VoucherName] NVARCHAR (50)   NULL,
    [Amount]      DECIMAL (18, 2) NULL
);

